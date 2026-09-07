part of 'cart_status_cubit.dart';

@immutable
sealed class CartStatusState {}

final class CartStatusInitial extends CartStatusState {}

final class CartStatusLoading extends CartStatusState {}

final class CartStatusLoaded extends CartStatusState {
  final bool areAllCartsEmpty;

  CartStatusLoaded({
    required this.areAllCartsEmpty,
  });
}

final class CartStatusError extends CartStatusState {
  final String message;

  CartStatusError({
    required this.message,
  });
}