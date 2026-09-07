import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:am_adel_dashboard/core/repos/product_repo/product_repo.dart';
import 'package:meta/meta.dart';
import '../../entities/offer_entity.dart';
import '../../repos/offer_repo/offer_repo.dart';
part 'offers_state.dart';

class OffersCubit extends Cubit<OfferState> {
  OffersCubit(this._offerRepo, this._productsRepo) : super(OffersInitial());
  final OfferRepo _offerRepo;
  final ProductRepo _productsRepo;
  List<OfferEntity> offers = [];
  StreamSubscription? _offersSubscription;

  Future<void> addOffer(OfferEntity offer) async {
    emit(OffersLoading());

    final result = await _offerRepo.addOffer(offer);

    await result.fold(
          (failure) {
        emit(OffersFailure(failure.errMessage));
      },
          (offerId) async {
        await _productsRepo.updateProductField(
          productId: offer.productId,
          data: {'offerId': offerId},
        );
        },
    );
  }

  void getOffers() {
    emit(GetOffersLoading());
    _offersSubscription = _offerRepo.getOffers().listen((data) {
      data.fold(
            (failure) async {
          emit(GeOffersFailure(failure.errMessage));
        },
            (offers) async {
          this.offers = offers;
            emit(GeOffersSuccess(offers));

        },
      );
    });
  }

  Future<void> deleteOffer(OfferEntity offer) async {
    emit(DeleteOfferLoading());

    final result = await _offerRepo.deleteOffer(offer.id);

    await result.fold(
          (failure) async {
        emit(DeleteOfferFailure(failure.errMessage));
      },
          (success) async {
        try {
          await _productsRepo.updateProductField(
            productId: offer.productId,
            data: {'offerId': null},
          );

          emit(DeleteOfferSuccess());
        } catch (e) {
          emit(DeleteOfferFailure(e.toString()));
        }
      },
    );
  }

  void resetState() {
    emit(OffersInitial());
  }

  Future<void> removeExpiredOffers() async {
    final now = DateTime.now();

    for (final offer in List<OfferEntity>.from(offers)) {
      if (offer.endDate.isBefore(now)) {
        await _offerRepo.deleteOffer(offer.id);

        await _productsRepo.updateProductField(
          productId: offer.productId,
          data: {'offerId': null},
        );
      }
    }
  }

  Future<void> deleteAllOffers() async {
    emit(DeleteAllOfferLoading());

    try {
      await _offerRepo.deleteCollection('offers');

      emit(DeleteAllOfferSuccess());
    } catch (e) {
      emit(DeleteAllOfferFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _offersSubscription?.cancel();
    return super.close();
  }
}
