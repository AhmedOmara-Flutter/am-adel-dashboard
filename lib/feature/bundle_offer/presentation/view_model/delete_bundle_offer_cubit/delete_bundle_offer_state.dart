part of 'delete_bundle_offer_cubit.dart';

@immutable
sealed class DeleteBundleOfferState {}

final class DeleteBundleOfferInitial
    extends DeleteBundleOfferState {}

final class DeleteBundleOfferLoading
    extends DeleteBundleOfferState {}

final class DeleteBundleOfferSuccess
    extends DeleteBundleOfferState {}

final class DeleteBundleOfferFailure
    extends DeleteBundleOfferState {
  final String errMessage;

  DeleteBundleOfferFailure(this.errMessage);
}

// =========================================================
// DELETE ALL
// =========================================================

final class DeleteAllBundleOfferLoading
    extends DeleteBundleOfferState {}

final class DeleteAllBundleOfferSuccess
    extends DeleteBundleOfferState {}

final class DeleteAllBundleOfferFailure
    extends DeleteBundleOfferState {
  final String errMessage;

  DeleteAllBundleOfferFailure(this.errMessage);
}