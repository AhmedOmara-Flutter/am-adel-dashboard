import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/entities/user_entity.dart';
import 'package:am_adel_dashboard/core/repos/orders_repo/orders_repo.dart';
import 'package:am_adel_dashboard/feature/clients/domain/repos/clients_repo.dart';
import 'package:meta/meta.dart';
part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this._clientsRepo, this._ordersRepo,)
      : super(ClientsInitial());

  final ClientsRepo _clientsRepo;
  final OrdersRepo _ordersRepo;
  List<UserEntity> clients = [];
  List<OrderEntity> orders = [];
  List<UserEntity> filteredClients = [];

  StreamSubscription? _clientsSubscription;
  StreamSubscription? _ordersSubscription;
  void loadData() {
    emit(GetClientsLoading());

    _clientsSubscription?.cancel();
    _ordersSubscription?.cancel();

    _clientsSubscription =
        _clientsRepo.getClients().listen((result) {
          result.fold(
                (failure) {
              emit(GetClientsFailure(failure.errMessage));
            },
                (data) {
                  clients = List.from(data);

                  clients.sort(
                        (a, b) => b.createdAt.compareTo(a.createdAt),
                  );

                  filteredClients = List.from(clients);

                  emit(GetClientsSuccess());
            },
          );
        });

    _ordersSubscription =
        _ordersRepo.getOrders().listen((result) {
          result.fold(
                (failure) {
              emit(GetClientsFailure(failure.errMessage));
            },
                (data) {
              orders = data;
              emit(GetClientsSuccess());
            },
          );
        });
  }

  List<OrderEntity> getOrdersForUser(String userId) {
    return orders.where((order) => order.uId == userId).toList();
  }

  void searchClients(String value) {

    if (value.isEmpty) {
      filteredClients = clients;
      emit(GetClientsSuccess());
      return;
    }
    filteredClients = clients.where((user) {
      return user.userName
          .toLowerCase()
          .contains(value.toLowerCase());
    }).toList();
    if (filteredClients.isEmpty) {
      emit(SearchClientsEmpty());
    } else {
      emit(GetClientsSuccess());
    }
  }


  @override
  Future<void> close() {
    _clientsSubscription?.cancel();
    _ordersSubscription?.cancel();
    return super.close();
  }

}