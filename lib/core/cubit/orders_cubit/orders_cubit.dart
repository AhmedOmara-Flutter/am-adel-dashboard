import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../entities/order_entity.dart';
import '../../../../core/models/top_product_model.dart';
import '../../../../core/repos/orders_repo/orders_repo.dart';
import '../../../../generated/assets.dart';
import '../../enums/order_enum.dart';
import '../../services/database_services.dart';
import '../../services/notification_service.dart';
import '../../services/print_service.dart';
import '../../services/printer_service.dart';
import '../../services/services_locator.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._ordersRepo) : super(OrdersInitial());
  final OrdersRepo _ordersRepo;
  double totalSales = 0;
  StreamSubscription? _ordersSubscription;
  List<OrderEntity> allOrders = [];
  List<OrderEntity> filteredOrders = [];
  OrderStatus? currentFilter = OrderStatus.pending;
  final List medals = [
    Assets.assets.images.medal.path,
    Assets.assets.images.medal1.path,
    Assets.assets.images.medal2.path,
    Assets.assets.images.medal3.path,
    Assets.assets.images.medal3.path,
  ];
  final Set<String> _printedOrders = {};
  void getOrders() {
    emit(GetOrdersLoadingState());
    _ordersSubscription?.cancel();
    _ordersSubscription = _ordersRepo.getOrders().listen((res) {
      res.fold(
        (failure) {
          emit(GetOrdersErrorState(failure.errMessage));
        },
        (data) async{
          allOrders = List.from(data)
            ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          for (final order in allOrders) {
            if (order.id == null) continue;
            if (order.status == OrderStatus.pending &&
                !_printedOrders.contains(order.id)) {
              _printedOrders.add(order.id!);

              try {
                await PrinterService.printOrder(order);
              } catch (e) {
                print('⚠️ Printer error: $e');
              }
            }
          }
          _applyFilter();

          totalSales = allOrders.fold(
            0.0,
            (sum, order) =>
                sum +
                order.cartEntity.cartItems.fold(
                  0.0,
                  (cartSum, item) => cartSum + item.totalPrice,
                ),
          );

          emit(GetOrdersSuccessState());
        },
      );
    });
  }

  void filterByStatus(OrderStatus status) {
    currentFilter = status;
    _applyFilter();
    emit(GetOrdersSuccessState());
  }

  List<OrderEntity> get recentOrders => allOrders.take(3).toList();

  List<TopProductModel> get topProducts {
    final Map<String, TopProductModel> products = {};
    for (var order in allOrders) {
      for (var item in order.cartEntity.cartItems) {
        final name = item.product.name;
        if (products.containsKey(name)) {
          products[name] = TopProductModel(
            name: name,
            image: item.product.image!,
            totalOrders: products[name]!.totalOrders + item.quantity,
          );
        } else {
          products[name] = TopProductModel(
            name: name,
            image: item.product.image!,
            totalOrders: item.quantity,
          );
        }
      }
    }

    final result = products.values.toList();

    result.sort((a, b) => b.totalOrders.compareTo(a.totalOrders));

    return result;
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async
  {
    emit(UpdateOrderLoadingState());

    final result = await _ordersRepo.updateOrderStatus(
      orderId: orderId,
      status: status,
    );

    await result.fold(
          (failure) async {
        emit(UpdateOrderErrorState(failure.errMessage));
      },
          (_) async {
        final index = allOrders.indexWhere(
              (e) => e.id == orderId,
        );

        if (index != -1) {
          final order = allOrders[index];

          allOrders[index] = order.copyWith(
            status: status,
          );
          if (status != OrderStatus.pending) {
            await _sendOrderStatusNotification(
              order,
              status,
            );
          }
        }
        if (currentFilter == null) {
          filteredOrders = List.from(allOrders);
        } else {
          filteredOrders = allOrders
              .where((o) => o.status == currentFilter)
              .toList();
        }

        emit(GetOrdersSuccessState());
      },
    );
  }

  Future<void> _sendOrderStatusNotification(
      OrderEntity order,
      OrderStatus status,
      ) async {
    try {
      final userData = await instance<DatabaseServices>().getData(
        path: 'users',
        uId: order.uId,
      );

      final String? fcmToken = userData['fcmToken'];

      if (fcmToken == null || fcmToken.isEmpty) {
        print('⚠️ No FCM Token found for user: ${order.uId}');
        return;
      }

      String title;
      String body;

      switch (status) {
        case OrderStatus.confirmed:
          title = 'تم تأكيد طلبك 🍕';
          body = 'طلبك قيد التحضير الآن';

          break;

        case OrderStatus.delivered:
          title = 'تم الانتهاء من طلبك 🎉';
          body = 'شكرًا لاختيارك بيتزا سفيان ❤️';

          break;

        case OrderStatus.cancelled:
          title = 'تم إلغاء طلبك ❌';
          body = 'تم إلغاء طلبك، نعتذر عن ذلك';

          break;

        case OrderStatus.pending:
          return;
      }

      await NotificationService.sendNotification(
        title: title,
        body: body,
        fcmToken: fcmToken,
      );

      print('✅ Order status notification sent');
    } catch (e) {
      print('❌ Failed to send order notification: $e');
    }
  }

  void showAllOrders() {
    currentFilter = null;
    _applyFilter();
    emit(GetOrdersSuccessState());
  }

  void _applyFilter() {
    if (currentFilter == null) {
      filteredOrders = List.from(allOrders);
    } else {
      filteredOrders = allOrders
          .where((o) => o.status == currentFilter)
          .toList();
    }
  }

  double get totalDeliveryCost {
    return allOrders.fold(
      0.0,
      (sum, order) => sum + (order.selectedLocationEntity?.cost ?? 0),
    );
  }

  double get totalPriceWithDelivery {
    return totalSales + totalDeliveryCost;
  }

  Future<void> deleteOrderCollection() async {
    emit(DeleteLoadingState());

    try {
      await _ordersRepo.deleteCollection('orders');

      emit(DeleteSuccessState());
    } catch (e) {
      emit(DeleteErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
