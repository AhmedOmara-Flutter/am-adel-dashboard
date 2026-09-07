part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class GetOrdersLoadingState extends OrdersState {}
final class GetOrdersEmptyState extends OrdersState {}

final class GetOrdersSuccessState extends OrdersState {}

final class GetOrdersErrorState extends OrdersState {
  final String errMessage;

  GetOrdersErrorState(this.errMessage);
}

final class UpdateOrderLoadingState extends OrdersState {}

final class UpdateOrderSuccessState extends OrdersState {}

final class UpdateOrderErrorState extends OrdersState {
  final String errMessage;

  UpdateOrderErrorState(this.errMessage);
}

final class GetFilteredOrdersEmpty extends OrdersState {}

final class GetFilteredOrdersSuccess extends OrdersState {
  final List<OrderEntity> filterProducts;
  GetFilteredOrdersSuccess({required this.filterProducts});
}

final class DeleteLoadingState extends OrdersState {}
final class DeleteSuccessState extends OrdersState {}
final class DeleteErrorState extends OrdersState {
  final String errMessage;
  DeleteErrorState(this.errMessage);
}


