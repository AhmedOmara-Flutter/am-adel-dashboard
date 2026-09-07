import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/core/models/offer_model.dart';
import 'package:am_adel_dashboard/core/entities/offer_entity.dart';
import 'package:am_adel_dashboard/core/repos/offer_repo/offer_repo.dart';

class OfferRepoImpl implements OfferRepo {
  final DatabaseServices _databaseServices;

  OfferRepoImpl(this._databaseServices);

  @override
  Future<Either<Failure, String>> addOffer(OfferEntity offer) async {
    try {
      final docRef = await _databaseServices.addData(
        path: 'offers',
        data: OfferModel.fromEntity(offer).toJson(),
      );
      return Right(docRef);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOffer(String offerId) async {
    try {
      final res = await _databaseServices.deleteData(
          path: 'offers', uId: offerId);
      return Right(res);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }


  @override
  Stream<Either<Failure, List<OfferEntity>>> getOffers() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>) in _databaseServices
          .getStreamData(path: 'offers')) {
        List<OfferEntity> offers = data
            .map((e) => OfferModel.fromJson(e).toEntity())
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
