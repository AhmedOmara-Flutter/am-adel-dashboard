import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/flash_offer_entity.dart';

abstract class FlashOfferRepo {
  Future<Either<Failure, String>> addFlashOffer(
      FlashOfferEntity offer,
      );

  Stream<Either<Failure, List<FlashOfferEntity>>> getFlashOffers();

  Future<Either<Failure, void>> deleteFlashOffer(
      String flashOfferId,
      );

  Future<void> deleteCollection(String collectionName);
}