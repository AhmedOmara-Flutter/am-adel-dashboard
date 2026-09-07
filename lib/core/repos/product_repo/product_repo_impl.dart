import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/core/models/product_model.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';

import 'product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final DatabaseServices _databaseServices;


  ProductRepoImpl(this._databaseServices);

  @override
  Future<Either<Failure, void>> addProduct(
      ProductEntity addProductEntity) async
  {
    try {
      var result = await _databaseServices.addData(
        path: 'products', data: ProductModel.fromEntity(addProductEntity).toJson(),);
      return Right(result);

    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity productEntity) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,void>> deleteProduct(String productId) async {
    try {
      final res= await _databaseServices.deleteData(path: 'products', uId: productId);
      return Right(res);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<void> deleteCollection(String collectionName)async {
    return await _databaseServices.deleteCollection(collectionName);
  }

  @override
  Stream<Either<Failure, List<ProductEntity>>> getProducts() async* {
    try {
      await for(var (data as List<Map<String, dynamic>> )in _databaseServices.getStreamData(path: 'products') ){
        List<ProductEntity> products = data.map((e) =>
            ProductModel.fromJson(e).toEntity()).toList();
        yield Right(products);

      }
    } on Exception catch (e) {
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProductField({required String productId, required Map<String, dynamic> data}) async{
    try {
      await _databaseServices.updateData(
        path: 'products',
        docId: productId,
        data: data,
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }

  }
  @override
  Future<Either<Failure, void>> addIsPausedToAllProducts() async {
    try {
      final data = await _databaseServices.getData(
        path: 'products',
      );

      final products = List<Map<String, dynamic>>.from(data);

      for (final product in products) {
        final productId = product['id'];

        if (productId == null) {
          continue;
        }

        // لو المنتج عنده isPaused بالفعل، متلمسوش
        if (product.containsKey('isPaused')) {
          continue;
        }

        await _databaseServices.updateData(
          path: 'products',
          docId: productId,
          data: {
            'isPaused': false,
          },
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }
}