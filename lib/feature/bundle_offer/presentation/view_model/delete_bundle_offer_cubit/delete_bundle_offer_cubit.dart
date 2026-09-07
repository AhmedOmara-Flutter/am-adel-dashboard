import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/bundle_offer_entity.dart';
import '../../../../../core/repos/bundle_offer_repo/bundle_offer_repo.dart';

part 'delete_bundle_offer_state.dart';

class DeleteBundleOfferCubit extends Cubit<DeleteBundleOfferState> {
  DeleteBundleOfferCubit(this._bundleOfferRepo)
    : super(DeleteBundleOfferInitial());

  final BundleOfferRepo _bundleOfferRepo;

  Future<void> deleteBundleOffer(BundleOfferEntity bundleOffer) async {
    emit(DeleteBundleOfferLoading());

    final result = await _bundleOfferRepo.deleteBundleOffer(bundleOffer.id!);

    result.fold(
      (failure) {
        emit(DeleteBundleOfferFailure(failure.errMessage));
      },
      (_) {
        emit(DeleteBundleOfferSuccess());
      },
    );
  }

  Future<void> deleteAllBundleOffers() async {
    emit(DeleteAllBundleOfferLoading());

    try {
      await _bundleOfferRepo.deleteCollection('bundle_offers');

      emit(DeleteAllBundleOfferSuccess());
    } catch (e) {
      emit(DeleteAllBundleOfferFailure(e.toString()));
    }
  }
}
