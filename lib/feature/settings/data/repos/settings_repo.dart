import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';

import '../../domain/entities/restaurant_status_entity.dart';

abstract class SettingsRepo {
  Future<Either<Failure, RestaurantStatusEntity>> getRestaurantStatus();

  Future<Either<Failure, void>> updateRestaurantStatus({
    required bool isOpen,
  });

  Stream<Either<Failure, RestaurantStatusEntity>> watchRestaurantStatus();
}