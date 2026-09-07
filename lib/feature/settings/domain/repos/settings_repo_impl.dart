import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';

import '../../data/models/restaurant_status_model.dart';
import '../../data/repos/settings_repo.dart';
import '../entities/restaurant_status_entity.dart';

class SettingsRepoImpl implements SettingsRepo {
  final DatabaseServices _databaseServices;
  SettingsRepoImpl(this._databaseServices);
  static const String _path = 'app_settings';
  static const String _docId = 'restaurant';

  @override
  Future<Either<Failure, RestaurantStatusEntity>> getRestaurantStatus() async {
    try {
      final exists = await _databaseServices.checkExists(
        path: _path,
        uId: _docId,
      );

      if (!exists) {
        await _databaseServices.addData(
          path: _path,
          uId: _docId,
          data: {'isOpen': true, 'updatedAt': FieldValue.serverTimestamp()},
        );

        return const Right(RestaurantStatusModel(isOpen: true));
      }

      final data = await _databaseServices.getData(path: _path, uId: _docId);

      return Right(
        RestaurantStatusModel.fromJson(Map<String, dynamic>.from(data)),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateRestaurantStatus({
    required bool isOpen,
  }) async {
    try {
      final exists = await _databaseServices.checkExists(
        path: _path,
        uId: _docId,
      );

      if (!exists) {
        await _databaseServices.addData(
          path: _path,
          uId: _docId,
          data: {'isOpen': isOpen, 'updatedAt': FieldValue.serverTimestamp()},
        );
      } else {
        await _databaseServices.updateData(
          path: _path,
          docId: _docId,
          data: {'isOpen': isOpen, 'updatedAt': FieldValue.serverTimestamp()},
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, RestaurantStatusEntity>>
  watchRestaurantStatus() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: _path,
        uId: _docId,
      )) {
        print('🔥 FIRESTORE RAW DATA => $data');
        print('🔥 isOpen RAW VALUE => ${data['isOpen']}');
        print('🔥 isOpen RAW TYPE => ${data['isOpen'].runtimeType}');

        final map = Map<String, dynamic>.from(data);

        if (map.isEmpty) {
          yield const Right(
            RestaurantStatusModel(isOpen: true),
          );
          continue;
        }

        final model = RestaurantStatusModel.fromJson(map);

        print('🔥 MODEL isOpen => ${model.isOpen}');

        yield Right(model);
      }
    } catch (e) {
      yield Left(
        Failure(errMessage: e.toString()),
      );
    }
  }
}
