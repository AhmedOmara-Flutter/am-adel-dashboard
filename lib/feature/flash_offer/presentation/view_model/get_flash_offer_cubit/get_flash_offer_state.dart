part of 'get_flash_offer_cubit.dart';

@immutable
sealed class GetFlashOfferState {}

final class GetFlashOfferInitial
    extends GetFlashOfferState {}

final class GetFlashOfferLoading
    extends GetFlashOfferState {}

final class GetFlashOfferSuccess
    extends GetFlashOfferState {
  final List<FlashOfferEntity> flashOffers;

  GetFlashOfferSuccess(this.flashOffers);
}

final class GetFlashOfferFailure
    extends GetFlashOfferState {
  final String errMessage;

  GetFlashOfferFailure(this.errMessage);
}