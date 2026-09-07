import 'package:bloc/bloc.dart';
import 'package:am_adel_dashboard/core/repos/product_repo/product_repo.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:meta/meta.dart';
import '../../../../core/repos/upload_image_repo/upload_image_repo.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this._productRepo, this._uploadImageRepo)
    : super(AddProductInitial());

  final ProductRepo _productRepo;
  final UploadImageRepo _uploadImageRepo;

  Future<void> addProduct(ProductEntity productEntity) async {
    emit(AddProductLoading());
    // رفع الصورة الرئيسية
    var mainImageResult = await _uploadImageRepo.uploadImage(
      productEntity.imageFile!,
    );
    await mainImageResult.fold(
      (failure) async {
        emit(AddProductFailure(failure.errMessage));
      },
      (mainImageResult) async {
        // رفع الصور الفرعية
        final subImagesResult = await _uploadImageRepo.uploadSubImages(
          productEntity.subImagesFiles!,
        );
        await subImagesResult.fold(
          (failure) async {
            emit(AddProductFailure(failure.errMessage));
          },
          (subImagesResult) async {
            productEntity.image = mainImageResult;
            productEntity.subImages = subImagesResult;
            final result = await _productRepo.addProduct(productEntity);
            await result.fold(
              (failure) async {
                print(failure.errMessage);
                emit(AddProductFailure(failure.errMessage));
              },
              (success) async {
                emit(AddProductSuccess());
              },
            );
          },
        );
      },
    );
  }
}
