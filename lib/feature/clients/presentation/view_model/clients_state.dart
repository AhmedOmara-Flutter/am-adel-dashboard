part of 'clients_cubit.dart';

@immutable
sealed class ClientsState {}

final class ClientsInitial extends ClientsState {}

final class GetClientsLoading extends ClientsState {}

final class GetClientsFailure extends ClientsState {
  final String errMessage;
  GetClientsFailure(this.errMessage);
}

final class GetClientsSuccess extends ClientsState {}
final class SearchClientsEmpty extends ClientsState {}

final class GetUserOrdersLoading extends ClientsState {}

final class GetUserOrdersFailure extends ClientsState {
  final String errMessage;

  GetUserOrdersFailure(this.errMessage);
}

final class GetUserOrdersSuccess extends ClientsState {
  final List<OrderEntity> orders;

  GetUserOrdersSuccess(this.orders);
}
