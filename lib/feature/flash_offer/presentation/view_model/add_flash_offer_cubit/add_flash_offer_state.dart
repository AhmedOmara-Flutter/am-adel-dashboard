part of 'add_flash_offer_cubit.dart';

@immutable
sealed class AddFlashOfferState {}

final class AddFlashOfferInitial extends AddFlashOfferState {}

final class AddFlashOfferLoading extends AddFlashOfferState {}

final class AddFlashOfferSuccess extends AddFlashOfferState {}

final class AddFlashOfferFailure extends AddFlashOfferState {
  final String errMessage;

  AddFlashOfferFailure(this.errMessage);
}