part of 'delete_flash_offer_cubit.dart';

@immutable
sealed class DeleteFlashOfferState {}

final class DeleteFlashOfferInitial
    extends DeleteFlashOfferState {}

final class DeleteFlashOfferLoading
    extends DeleteFlashOfferState {}

final class DeleteFlashOfferSuccess
    extends DeleteFlashOfferState {}

final class DeleteFlashOfferFailure
    extends DeleteFlashOfferState {
  final String errMessage;

  DeleteFlashOfferFailure(this.errMessage);
}

// =========================================================
// DELETE ALL
// =========================================================

final class DeleteAllFlashOfferLoading
    extends DeleteFlashOfferState {}

final class DeleteAllFlashOfferSuccess
    extends DeleteFlashOfferState {}

final class DeleteAllFlashOfferFailure
    extends DeleteFlashOfferState {
  final String errMessage;

  DeleteAllFlashOfferFailure(this.errMessage);
}