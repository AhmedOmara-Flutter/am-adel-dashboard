import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, void>> addProduct(ProductEntity addProductEntity);
  Future<Either<Failure, void>> updateProduct(ProductEntity productEntity);
  Future<Either<Failure, void>> updateProductField({
    required String productId,
    required Map<String, dynamic> data,
  });
  Future<void> deleteProduct(String productId);
  Future<void> deleteCollection(String collectionName);
  Stream<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, void>> addIsPausedToAllProducts();
}
