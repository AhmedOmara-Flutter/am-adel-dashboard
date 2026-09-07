import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/entities/offer_entity.dart';
import '../../errors/failure.dart';

abstract class OfferRepo {
  Future<Either<Failure, String>> addOffer(OfferEntity offer,);

  Stream<Either<Failure, List<OfferEntity>>> getOffers();

  Future<Either<Failure, void>> deleteOffer(String offerId,);

  Future<void> deleteCollection(String collectionName);

}
