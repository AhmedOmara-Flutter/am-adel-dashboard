part of 'offers_cubit.dart';

@immutable
sealed class OfferState {}

final class OffersInitial extends OfferState {}
final class OffersLoading extends OfferState {}
final class OffersFailure extends OfferState {
  final String errMessage;
  OffersFailure(this.errMessage);
}
final class OffersSuccess extends OfferState {}

final class GetOffersLoading extends OfferState {}
final class  GeOffersFailure extends OfferState {
  final String errMessage;
  GeOffersFailure(this.errMessage);
}
final class  GeOffersSuccess extends OfferState {
  final List<OfferEntity> offers;
  GeOffersSuccess(this.offers);
}

class DeleteOfferLoading extends OfferState {}
class DeleteOfferSuccess extends OfferState {}
class DeleteOfferFailure extends OfferState {
  final String message;
  DeleteOfferFailure(this.message);
}

class DeleteAllOfferLoading extends OfferState {}
class DeleteAllOfferSuccess extends OfferState {}
class DeleteAllOfferFailure extends OfferState {
  final String message;
  DeleteAllOfferFailure(this.message);
}
