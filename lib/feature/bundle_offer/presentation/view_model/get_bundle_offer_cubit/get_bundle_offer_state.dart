part of 'get_bundle_offer_cubit.dart';

@immutable
sealed class GetBundleOfferState {}

final class GetBundleOfferInitial
    extends GetBundleOfferState {}

final class GetBundleOfferLoading
    extends GetBundleOfferState {}

final class GetBundleOfferSuccess
    extends GetBundleOfferState {
  final List<BundleOfferEntity> bundleOffers;

  GetBundleOfferSuccess(this.bundleOffers);
}

final class GetBundleOfferFailure
    extends GetBundleOfferState {
  final String errMessage;

  GetBundleOfferFailure(this.errMessage);
}