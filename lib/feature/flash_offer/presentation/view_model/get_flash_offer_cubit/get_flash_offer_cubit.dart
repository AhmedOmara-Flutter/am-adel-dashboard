import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repo/flash_offer_repo.dart';
import '../../../domain/entities/flash_offer_entity.dart';

part 'get_flash_offer_state.dart';

class GetFlashOfferCubit extends Cubit<GetFlashOfferState> {
  GetFlashOfferCubit(this._flashOfferRepo)
      : super(GetFlashOfferInitial());

  final FlashOfferRepo _flashOfferRepo;

  StreamSubscription? _subscription;

  void getFlashOffers() {
    emit(GetFlashOfferLoading());

    _subscription?.cancel();

    _subscription = _flashOfferRepo.getFlashOffers().listen(
          (result) {
        result.fold(
              (failure) {
            emit(
              GetFlashOfferFailure(
                failure.errMessage,
              ),
            );
          },
              (offers) {
            final sortedOffers = [...offers]
              ..sort(
                    (a, b) => b.createdAt.compareTo(
                  a.createdAt,
                ),
              );

            emit(
              GetFlashOfferSuccess(
                sortedOffers,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}