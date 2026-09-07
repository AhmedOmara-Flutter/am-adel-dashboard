import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';
import '../../data/repos/settings_repo.dart';
import '../../domain/entities/restaurant_status_entity.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo _settingsRepo;

  StreamSubscription<Either<Failure, RestaurantStatusEntity>>?
  _restaurantStatusSubscription;

  SettingsCubit(this._settingsRepo) : super(SettingsInitial());
  bool isRestaurantOpen = true;

  void getRestaurantStatus() {
    if (isClosed) return;

    print('🔥 getRestaurantStatus CALLED');

    emit(SettingsLoading());

    _restaurantStatusSubscription?.cancel();

    _restaurantStatusSubscription =
        _settingsRepo.watchRestaurantStatus().listen(
              (result) {
            print('🔥 RESTAURANT STATUS RESULT RECEIVED');

            if (isClosed) return;

            result.fold(
                  (failure) {
                print('❌ STATUS ERROR: ${failure.errMessage}');

                emit(
                  SettingsError(
                    message: failure.errMessage,
                  ),
                );
              },
                  (status) {
                print('🔥 FIRESTORE isOpen = ${status.isOpen}');

                isRestaurantOpen = status.isOpen;

                emit(
                  SettingsLoaded(
                    restaurantStatus: status,
                  ),
                );
              },
            );
          },
          onError: (error) {
            print('❌ STREAM ERROR: $error');

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
    if (isClosed) return;

    final oldStatus = isRestaurantOpen;
    final newStatus = !oldStatus;

    isRestaurantOpen = newStatus;

    emit(
      SettingsLoaded(
        restaurantStatus: RestaurantStatusEntity(isOpen: newStatus),
      ),
    );

    final result = await _settingsRepo.updateRestaurantStatus(
      isOpen: newStatus,
    );

    if (isClosed) return;

    result.fold((failure) {
      isRestaurantOpen = oldStatus;

      emit(
        SettingsLoaded(
          restaurantStatus: RestaurantStatusEntity(isOpen: oldStatus),
        ),
      );
    }, (_) {});
  }

  @override
  Future<void> close() async {
    await _restaurantStatusSubscription?.cancel();

    _restaurantStatusSubscription = null;

    return super.close();
  }
}
