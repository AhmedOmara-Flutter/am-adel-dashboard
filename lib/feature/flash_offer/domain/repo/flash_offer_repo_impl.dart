import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../data/repo/flash_offer_repo.dart';
import '../../domain/entities/flash_offer_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/flash_offer_model.dart';
import '../../../../core/services/database_services.dart';

class FlashOfferRepoImpl implements FlashOfferRepo {
  final DatabaseServices _databaseServices;

  FlashOfferRepoImpl(this._databaseServices);

  @override
  Future<Either<Failure, String>> addFlashOffer(
      FlashOfferEntity offer,
      ) async {
    try {
      final docRef = await _databaseServices.addData(
        path: 'flash_offers',
        data: FlashOfferModel.fromEntity(offer).toJson(),
      );

      await _increaseFlashOffersVersion();

      return Right(docRef);
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteFlashOffer(
      String flashOfferId,
      ) async {
    try {
      final res = await _databaseServices.deleteData(
        path: 'flash_offers',
        uId: flashOfferId,
      );

      await _increaseFlashOffersVersion();

      return Right(res);
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Stream<Either<Failure, List<FlashOfferEntity>>> getFlashOffers() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>)
      in _databaseServices.getStreamData(
        path: 'flash_offers',
      )) {
        final offers = data
            .map(
              (e) => FlashOfferModel.fromJson(e).toEntity(),
        )
            .toList();

        yield Right(offers);
      }
    } on Exception catch (e) {
      yield Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> deleteCollection(String collectionName) async {
    await _databaseServices.deleteCollection(
      collectionName,
    );

    await _increaseFlashOffersVersion();
  }

  Future<void> _increaseFlashOffersVersion() async {
    await _databaseServices.updateData(
      path: 'app_settings',
      docId: 'cache_versions',
      data: {
        'flashOffersVersion': FieldValue.increment(1),
      },
    );
  }
}