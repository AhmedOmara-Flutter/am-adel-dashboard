part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class GetProductsLoadingState extends ProductsState {}

final class GetProductsErrorState extends ProductsState {
  final String errMessage;

  GetProductsErrorState({required this.errMessage});
}

final class GetProductsSuccessState extends ProductsState {
  final List<ProductEntity> products;

  GetProductsSuccessState({required this.products});
}

final class GetFilteredProductsLoading extends ProductsState {}
final class GetFilteredProductsError extends ProductsState {
  final String errMessage;
  GetFilteredProductsError(this.errMessage);
}
final class GetFilteredProductsSuccess extends ProductsState {
  final List<ProductEntity> filterProducts;

  GetFilteredProductsSuccess({required this.filterProducts});
}
final class GetFilteredProductsEmpty extends ProductsState {}

final class DeleteProductLoading extends ProductsState {}
final class DeleteProductSuccess extends ProductsState {}
final class DeleteProductError extends ProductsState {
  final String errMessage;
  DeleteProductError(this.errMessage);
}

final class DeleteCartLoadingState extends ProductsState {}
final class DeleteCartSuccessState extends ProductsState {}
final class DeleteCartErrorState extends ProductsState {
  final String errMessage;
  DeleteCartErrorState(this.errMessage);
}


class AddIsPausedLoading extends ProductsState {}

class AddIsPausedSuccess extends ProductsState {}

class AddIsPausedError extends ProductsState {
  final String message;

  AddIsPausedError(this.message);
}