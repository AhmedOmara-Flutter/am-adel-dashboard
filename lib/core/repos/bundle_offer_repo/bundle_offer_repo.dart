import 'package:dartz/dartz.dart';
import '../../entities/bundle_offer_entity.dart';
import '../../errors/failure.dart';

abstract class BundleOfferRepo {
  Future<Either<Failure, String>> addBundleOffer(BundleOfferEntity offer,);

  Stream<Either<Failure, List<BundleOfferEntity>>> getBundleOffers();

  Future<Either<Failure, void>> deleteBundleOffer(String bundleOfferId,);

  Future<void> deleteCollection(String collectionName);

}
