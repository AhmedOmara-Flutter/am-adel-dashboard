import 'package:bloc/bloc.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/repos/product_repo/product_repo.dart';
import 'package:am_adel_dashboard/core/repos/upload_image_repo/upload_image_repo.dart';
import 'package:meta/meta.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit(this._productRepo, this._uploadImageRepo)
      : super(UpdateProductInitial());

  final ProductRepo _productRepo;
  final UploadImageRepo _uploadImageRepo;

  Future<void> updateProduct(ProductEntity product) async {
    emit(UpdateProductLoading());

    try {
      String? mainImageUrl = product.image;

      if (product.imageFile != null) {
        final mainImageResult =
        await _uploadImageRepo.uploadImage(product.imageFile!);

        await mainImageResult.fold(
              (failure) async {
            emit(UpdateProductError(failure.errMessage));
            return;
          },
              (url) async {
            mainImageUrl = url;
          },
        );
      }

      List<String> finalSubImages = product.subImages ?? [];

      if (product.subImagesFiles != null &&
          product.subImagesFiles!.isNotEmpty) {
        final uploadResult =
        await _uploadImageRepo.uploadSubImages(product.subImagesFiles!);

        await uploadResult.fold(
              (failure) async {
            emit(UpdateProductError(failure.errMessage));
            return;
          },
              (uploadedUrls) async {
            finalSubImages = [
              ...finalSubImages,
              ...uploadedUrls,
            ];
          },
        );
      }

      final updatedProduct = product.copyWith(
        image: mainImageUrl,
        subImages: finalSubImages,
      );

      final result = await _productRepo.updateProductField(
        productId: updatedProduct.id!,
        data: {
          'name': updatedProduct.name,
          'code': updatedProduct.code,
          'price': updatedProduct.price,
          'description': updatedProduct.description,
          'image': updatedProduct.image,
          'subImages': updatedProduct.subImages,
          'category': updatedProduct.category,
          'size': updatedProduct.size,
          'isFeatured': updatedProduct.isFeatured,
          'isOrganic': updatedProduct.isOrganic,
          'expirationMonth': updatedProduct.expirationMonth,
          'unitAmount': updatedProduct.unitAmount,
          'numberOfCalories': updatedProduct.numberOfCalories,
        },
      );

      result.fold(
            (failure) {
          emit(UpdateProductError(failure.errMessage));
        },
            (_) {
          emit(UpdateProductSuccess());
        },
      );
    } catch (e) {
      emit(UpdateProductError(e.toString()));
    }
  }
}