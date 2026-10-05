import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../entities/bundle_offer_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/bundle_offer_model.dart';
import '../../../../core/services/database_services.dart';
import '../../data/repos/bundle_offer_repo.dart';

class BundleOfferRepoImpl implements BundleOfferRepo {
  final DatabaseServices _databaseServices;

  BundleOfferRepoImpl(this._databaseServices);

  @override
  Future<Either<Failure, String>> addBundleOffer(
    BundleOfferEntity offer,
  ) async {
    try {
      final docRef = await _databaseServices.addData(
        path: 'bundle_offers',
        data: BundleOfferModel.fromEntity(offer).toJson(),
      );

      await _increaseBundleOffersVersion();

      return Right(docRef);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBundleOffer(String bundleOfferId) async {
    try {
      final res = await _databaseServices.deleteData(
        path: 'bundle_offers',
        uId: bundleOfferId,
      );

      await _increaseBundleOffersVersion();

      return Right(res);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<BundleOfferEntity>>> getBundleOffers() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>)
          in _databaseServices.getStreamData(path: 'bundle_offers')) {
        final offers = data
            .map((e) => BundleOfferModel.fromJson(e).toEntity())
            .toList();

        yield Right(offers);
      }
    } on Exception catch (e) {
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<void> deleteCollection(String collectionName) async {
    return await _databaseServices.deleteCollection(collectionName);
  }

  Future<void> _increaseBundleOffersVersion() async {
    await _databaseServices.updateData(
      path: 'app_settings',
      docId: 'cache_versions',
      data: {'bundleOffersVersion': FieldValue.increment(1)},
    );
  }
}
