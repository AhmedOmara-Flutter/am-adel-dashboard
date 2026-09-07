import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';

import '../../entities/order_entity.dart';
import '../../enums/order_enum.dart';
import '../../models/order_model.dart';

abstract class OrdersRepo {
  Stream<Either<Failure, List<OrderEntity>>> getOrders();

  Future<Either<Failure, void>> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  });

  Future<void> deleteCollection(String collectionName);
  }

class OrdersRepoImpl implements OrdersRepo {
  final DatabaseServices _databaseServices;

  OrdersRepoImpl(this._databaseServices);

  @override
  Stream<Either<Failure, List<OrderEntity>>> getOrders() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>)
          in _databaseServices.getStreamData(path: 'orders')) {
        List<OrderEntity> orders = data
            .map((user) => OrderModel.fromJson(user).toEntity())
            .toList();
        yield Right(orders);
      }
    } catch (e) {
      print('error from get orders is ${e.toString()}');
      yield Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    try {
      await _databaseServices.updateData(
        path: 'orders',
        data: {'status': status.name},
        docId: orderId,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<void> deleteCollection(String collectionName)async {
    return await _databaseServices.deleteCollection(collectionName);
  }
}
