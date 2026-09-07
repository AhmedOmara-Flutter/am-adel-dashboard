import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/repos/product_repo/product_repo.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productRepo) : super(ProductsInitial());
  final ProductRepo _productRepo;
  StreamSubscription? _productsSubscription;
  List<ProductEntity> filteredProducts = [];
  List<ProductEntity> allProducts = [];

  void getProducts() {
    _productsSubscription?.cancel();

    emit(GetProductsLoadingState());
    _productsSubscription = _productRepo.getProducts().listen((data) {
      data.fold(
        (failure) {
          emit(GetProductsErrorState(errMessage: failure.errMessage));
        },
        (data) {
          allProducts = data;
          filteredProducts = data;

          emit(GetProductsSuccessState(products: data));
        },
      );
    });
  }
  void filterProducts(
      String category, {
        String? size,
      }) {
    final result = allProducts.where((product) {
      final categoryMatch = product.category == category;

      if (size == null) {
        return categoryMatch;
      }

      return categoryMatch && product.size == size;
    }).toList();

    filteredProducts = result;

    if (result.isEmpty) {
      emit(GetFilteredProductsEmpty());
    } else {
      emit(
        GetFilteredProductsSuccess(
          filterProducts: result,
        ),
      );
    }
  }
  Future<void> deleteProduct(String productId) async {
    emit(DeleteProductLoading());
    try {
      await _productRepo.deleteProduct(productId);
      filteredProducts.removeWhere((p) => p.id == productId);

      emit(DeleteProductSuccess());
    } catch (e) {
      emit(DeleteProductError(e.toString()));
    }
  }

  Future<void> deleteCartCollectionForUser() async {
    emit(DeleteCartLoadingState());

    try {
      await _productRepo.deleteCollection('carts');

      emit(DeleteCartSuccessState());
    } catch (e) {
      emit(DeleteCartErrorState(e.toString()));
    }
  }

  Future<void> addIsPausedToAllProducts() async {
    emit(AddIsPausedLoading());

    final result = await _productRepo.addIsPausedToAllProducts();

    result.fold(
          (failure) {
        emit(
          AddIsPausedError(
            failure.errMessage,
          ),
        );
      },
          (_) {
        emit(AddIsPausedSuccess());
      },
    );
  }

  Future<void> toggleProductPaused(
      String productId,
      bool isPaused,
      ) async
  {
    final result = await _productRepo.updateProductField(
      productId: productId,
      data: {
        'isPaused': isPaused,
      },
    );

    result.fold(
          (failure) {
        emit(
          GetProductsErrorState(
            errMessage: failure.errMessage,
          ),
        );
      },
          (_) {
        final index = allProducts.indexWhere(
              (product) => product.id == productId,
        );

        if (index != -1) {
          allProducts[index] = allProducts[index].copyWith(
            isPaused: isPaused,
          );
        }

        final filteredIndex = filteredProducts.indexWhere(
              (product) => product.id == productId,
        );

        if (filteredIndex != -1) {
          filteredProducts[filteredIndex] =
              filteredProducts[filteredIndex].copyWith(
                isPaused: isPaused,
              );
        }

        emit(
          GetProductsSuccessState(
            products: allProducts,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }
}
