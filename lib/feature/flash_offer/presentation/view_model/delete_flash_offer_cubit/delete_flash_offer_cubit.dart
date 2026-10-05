import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repo/flash_offer_repo.dart';
import '../../../domain/entities/flash_offer_entity.dart';

part 'delete_flash_offer_state.dart';

class DeleteFlashOfferCubit extends Cubit<DeleteFlashOfferState> {
  DeleteFlashOfferCubit(this._flashOfferRepo)
      : super(DeleteFlashOfferInitial());

  final FlashOfferRepo _flashOfferRepo;

  Future<void> deleteFlashOffer(
      FlashOfferEntity flashOffer,
      ) async {
    emit(DeleteFlashOfferLoading());

    final result = await _flashOfferRepo.deleteFlashOffer(
      flashOffer.id!,
    );

    result.fold(
          (failure) {
        emit(DeleteFlashOfferFailure(failure.errMessage));
      },
          (_) {
        emit(DeleteFlashOfferSuccess());
      },
    );
  }

  Future<void> deleteAllFlashOffers() async {
    emit(DeleteAllFlashOfferLoading());

    try {
      await _flashOfferRepo.deleteCollection(
        'flash_offers',
      );

      emit(DeleteAllFlashOfferSuccess());
    } catch (e) {
      emit(
        DeleteAllFlashOfferFailure(
          e.toString(),
        ),
      );
    }
  }
}