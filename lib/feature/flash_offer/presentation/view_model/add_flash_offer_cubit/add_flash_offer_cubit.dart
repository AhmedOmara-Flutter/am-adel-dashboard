import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repo/flash_offer_repo.dart';
import '../../../domain/entities/flash_offer_entity.dart';
import '../../../../../core/repos/upload_image_repo/upload_image_repo.dart';

part 'add_flash_offer_state.dart';

class AddFlashOfferCubit extends Cubit<AddFlashOfferState> {
  AddFlashOfferCubit(
      this._flashOfferRepo,
      this._uploadImageRepo,
      ) : super(AddFlashOfferInitial());

  final FlashOfferRepo _flashOfferRepo;
  final UploadImageRepo _uploadImageRepo;

  Future<void> addFlashOffer(
      FlashOfferEntity flashOfferEntity,
      ) async {
    emit(AddFlashOfferLoading());

    final imageResult = await _uploadImageRepo.uploadImage(
      flashOfferEntity.imageUrl!,
    );

    await imageResult.fold(
          (failure) async {
        emit(AddFlashOfferFailure(failure.errMessage));
      },
          (imageUrl) async {
        final updatedFlashOffer = FlashOfferEntity(
          image: imageUrl,
          createdAt: flashOfferEntity.createdAt,
        );

        final result = await _flashOfferRepo.addFlashOffer(
          updatedFlashOffer,
        );

        result.fold(
              (failure) {
            emit(AddFlashOfferFailure(failure.errMessage));
          },
              (success) {
            emit(AddFlashOfferSuccess());
          },
        );
      },
    );
  }
}