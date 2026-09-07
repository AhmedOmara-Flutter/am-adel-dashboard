part of 'add_bundle_offer_cubit.dart';

@immutable
sealed class AddBundleOfferState {}

final class AddBundleOfferInitial extends AddBundleOfferState {}

final class AddBundleOfferLoading extends AddBundleOfferState {}

final class AddBundleOfferSuccess extends AddBundleOfferState {}

final class AddBundleOfferFailure extends AddBundleOfferState {
  final String errMessage;

  AddBundleOfferFailure(this.errMessage);
}
