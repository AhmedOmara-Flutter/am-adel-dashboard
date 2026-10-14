import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/entities/user_entity.dart';
import 'package:am_adel_dashboard/core/repos/orders_repo/orders_repo.dart';
import 'package:am_adel_dashboard/feature/clients/domain/repos/clients_repo.dart';
import 'package:meta/meta.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
ClientsCubit(
this._clientsRepo,
this._ordersRepo,
) : super(ClientsInitial());

final ClientsRepo _clientsRepo;
final OrdersRepo _ordersRepo;

List<UserEntity> clients = [];
List<OrderEntity> orders = [];
List<UserEntity> filteredClients = [];

// Historical order count from customer_stats.
final Map<String, int> customerOrdersCounts = {};

StreamSubscription? _clientsSubscription;
StreamSubscription? _ordersSubscription;

final Map<String, StreamSubscription> _customerSubscriptions = {};

void loadData() {
emit(GetClientsLoading());

_clientsSubscription?.cancel();
_ordersSubscription?.cancel();

for (final subscription in _customerSubscriptions.values) {
subscription.cancel();
}

_customerSubscriptions.clear();
customerOrdersCounts.clear();

_clientsSubscription = _clientsRepo.getClients().listen((result) {
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

for (final user in clients) {
_listenToCustomerOrders(user.uId);
}

emit(GetClientsSuccess());
},
);
});

_ordersSubscription = _ordersRepo.getOrders().listen((result) {
result.fold(
(failure) {
emit(GetClientsFailure(failure.errMessage));
},
(data) {
// Keep the original orders list unchanged.
orders = data;
emit(GetClientsSuccess());
},
);
});
}

void _listenToCustomerOrders(String userId) {
if (userId.isEmpty ||
_customerSubscriptions.containsKey(userId)) {
return;
}

_customerSubscriptions[userId] =
_clientsRepo.getCustomerOrdersCount(userId).listen((result) {
result.fold(
(failure) {
// Keep the historical count at its default value on failure.
},
(count) {
customerOrdersCounts[userId] = count;
emit(GetClientsSuccess());
},
);
});
}

// Historical count from customer_stats.
int getCustomerOrdersCount(String userId) {
return customerOrdersCounts[userId] ?? 0;
}

// Original method: orders loaded from the orders collection.
List<OrderEntity> getOrdersForUser(String userId) {
return orders.where((order) => order.uId == userId).toList();
}

void searchClients(String value) {
if (value.isEmpty) {
filteredClients = List.from(clients);
emit(GetClientsSuccess());
return;
}

filteredClients = clients.where((user) {
return user.userName.toLowerCase().contains(
value.toLowerCase(),
);
}).toList();

if (filteredClients.isEmpty) {
emit(SearchClientsEmpty());
} else {
emit(GetClientsSuccess());
}
}

@override
Future<void> close() async {
await _clientsSubscription?.cancel();
await _ordersSubscription?.cancel();

for (final subscription in _customerSubscriptions.values) {
await subscription.cancel();
}

_customerSubscriptions.clear();

return super.close();
}
}
