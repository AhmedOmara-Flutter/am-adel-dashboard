import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/bundle_offer_entity.dart';
import '../../../../../core/repos/bundle_offer_repo/bundle_offer_repo.dart';
import '../../../../../core/repos/upload_image_repo/upload_image_repo.dart';

part 'add_bundle_offer_state.dart';

class AddBundleOfferCubit extends Cubit<AddBundleOfferState> {
  AddBundleOfferCubit(
      this._bundleOfferRepo,
      this._uploadImageRepo,
      ) : super(AddBundleOfferInitial());

  final BundleOfferRepo _bundleOfferRepo;
  final UploadImageRepo _uploadImageRepo;

  Future<void> addBundleOffer(
      BundleOfferEntity bundleOfferEntity,
      ) async {
    emit(AddBundleOfferLoading());

    final imageResult = await _uploadImageRepo.uploadImage(
      bundleOfferEntity.imageUrl!,
    );

    await imageResult.fold(
          (failure) async {
        emit(AddBundleOfferFailure(failure.errMessage));
      },
          (imageUrl) async {
        final updatedBundleOffer = BundleOfferEntity(
          image: imageUrl,
          title: bundleOfferEntity.title,
          description: bundleOfferEntity.description,
          price: bundleOfferEntity.price,
          createdAt: bundleOfferEntity.createdAt,
        );

        final result = await _bundleOfferRepo.addBundleOffer(
          updatedBundleOffer,
        );

        result.fold(
              (failure) {
            emit(AddBundleOfferFailure(failure.errMessage));
          },
              (success) {
            emit(AddBundleOfferSuccess());
          },
        );
      },
    );
  }
}