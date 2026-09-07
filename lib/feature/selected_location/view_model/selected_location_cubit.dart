import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/entities/selected_location_entity.dart';
import '../../../core/repos/location_repo/selected_location_repo.dart';

part 'selected_location_state.dart';

class SelectedLocationCubit extends Cubit<SelectedLocationState> {
  final SelectedLocationRepo _selectedLocationRepo;

  StreamSubscription<List<SelectedLocationEntity>>? _locationsSubscription;

  SelectedLocationCubit(this._selectedLocationRepo)
    : super(SelectedLocationInitial());

  List<SelectedLocationEntity> locations = [];

  void getLocations() {
    emit(SelectedLocationGetLoading());

    _locationsSubscription?.cancel();

    _locationsSubscription = _selectedLocationRepo.getLocationsStream().listen(
      (locations) {
        this.locations = locations;

        emit(SelectedLocationGetSuccess(locations: locations));
      },
      onError: (error) {
        emit(SelectedLocationGetError(message: error.toString()));
      },
    );
  }

  Future<void> addLocation(SelectedLocationEntity location) async {
    emit(SelectedLocationAddLoading());

    try {
      await _selectedLocationRepo.addLocation(location);

      emit(SelectedLocationAddSuccess());
    } catch (e) {
      emit(SelectedLocationAddError(message: e.toString()));
    }
  }

  Future<void> updateLocation(SelectedLocationEntity location) async {
    emit(SelectedLocationUpdateLoading());

    try {
      await _selectedLocationRepo.updateLocation(location);

      emit(SelectedLocationUpdateSuccess());
    } catch (e) {
      emit(SelectedLocationUpdateError(message: e.toString()));
    }
  }

  Future<void> deleteLocation(String id) async {
    emit(SelectedLocationDeleteLoading());

    try {
      await _selectedLocationRepo.deleteLocation(id);

      emit(SelectedLocationDeleteSuccess());
    } catch (e) {
      emit(SelectedLocationDeleteError(message: e.toString()));
    }
  }

  Future<bool> checkLocationExists(String id) async {
    try {
      return await _selectedLocationRepo.checkLocationExists(id);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> close() {
    _locationsSubscription?.cancel();
    return super.close();
  }
}
