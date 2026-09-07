import 'package:dartz/dartz.dart';
import '../../entities/bundle_offer_entity.dart';
import '../../errors/failure.dart';
import '../../models/bundle_offer_model.dart';
import '../../services/database_services.dart';
import 'bundle_offer_repo.dart';

class BundleOfferRepoImpl implements BundleOfferRepo {
  final DatabaseServices _databaseServices;

  BundleOfferRepoImpl(this._databaseServices);

  @override
  Future<Either<Failure, String>> addBundleOffer(BundleOfferEntity offer) async {
    try {
      final docRef = await _databaseServices.addData(
        path: 'bundle_offers',
        data: BundleOfferModel.fromEntity(offer).toJson(),
      );
      return Right(docRef);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBundleOffer(String bundleOfferId) async {
    try {
      final res = await _databaseServices.deleteData(
          path: 'bundle_offers', uId: bundleOfferId);
      return Right(res);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }


  @override
  Stream<Either<Failure, List<BundleOfferEntity>>> getBundleOffers() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>) in _databaseServices
          .getStreamData(path: 'bundle_offers')) {
        List<BundleOfferEntity> offers = data
            .map((e) => BundleOfferModel.fromJson(e).toEntity())
            .toList();
        yield Right(offers);
      }
    } on Exception catch (e) {
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<void> deleteCollection(String collectionName)async {
    return await _databaseServices.deleteCollection(collectionName);
  }
}
