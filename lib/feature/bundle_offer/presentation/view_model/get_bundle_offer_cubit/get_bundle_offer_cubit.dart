import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/bundle_offer_entity.dart';
import '../../../../../core/repos/bundle_offer_repo/bundle_offer_repo.dart';

part 'get_bundle_offer_state.dart';

class GetBundleOfferCubit extends Cubit<GetBundleOfferState> {
  GetBundleOfferCubit(this._bundleOfferRepo)
      : super(GetBundleOfferInitial());

  final BundleOfferRepo _bundleOfferRepo;

  StreamSubscription? _subscription;

  void getBundleOffers() {
    emit(GetBundleOfferLoading());

    _subscription?.cancel();

    _subscription = _bundleOfferRepo.getBundleOffers().listen(
          (result) {
        result.fold(
              (failure) {
            emit(
              GetBundleOfferFailure(
                failure.errMessage,
              ),
            );
          },
              (offers) {
            final sortedOffers = [...offers]
              ..sort(
                    (a, b) => b.createdAt.compareTo(a.createdAt),
              );

            emit(
              GetBundleOfferSuccess(sortedOffers),
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