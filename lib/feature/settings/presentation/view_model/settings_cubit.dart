import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/errors/failure.dart';
import '../../data/repos/settings_repo.dart';
import '../../domain/entities/restaurant_status_entity.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo _settingsRepo;

  SettingsCubit(this._settingsRepo) : super(SettingsInitial());

  StreamSubscription<Either<Failure, RestaurantStatusEntity>>?
  _restaurantStatusSubscription;

  bool _isUpdating = false;

  bool get isRestaurantOpen {
    final currentState = state;

    if (currentState is SettingsLoaded) {
      return currentState.restaurantStatus.isOpen;
    }

    return true;
  }

  void getRestaurantStatus() {
    if (isClosed) return;

    _restaurantStatusSubscription?.cancel();

    _restaurantStatusSubscription =
        _settingsRepo.watchRestaurantStatus().listen(
              (result) {
            if (isClosed) return;

            result.fold(
                  (failure) {
                emit(
                  SettingsError(
                    message: failure.errMessage,
                  ),
                );
              },
                  (status) {
                emit(
                  SettingsLoaded(
                    restaurantStatus: status,
                  ),
                );
              },
            );
          },
          onError: (error) {
            if (isClosed) return;

            emit(
              SettingsError(
                message: error.toString(),
              ),
            );
          },
        );
  }

  Future<void> toggleRestaurantStatus() async {
    if (isClosed || _isUpdating) return;

    _isUpdating = true;

    final newStatus = !isRestaurantOpen;

    final result = await _settingsRepo.updateRestaurantStatus(
      isOpen: newStatus,
    );

    if (isClosed) {
      _isUpdating = false;
      return;
    }

    result.fold(
          (failure) {
        emit(
          SettingsError(
            message: failure.errMessage,
          ),
        );
      },
          (_) {},
    );

    _isUpdating = false;
  }

  @override
  Future<void> close() async {
    await _restaurantStatusSubscription?.cancel();
    _restaurantStatusSubscription = null;

    return super.close();
  }
}