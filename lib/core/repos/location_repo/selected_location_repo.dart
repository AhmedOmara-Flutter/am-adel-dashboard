import '../../entities/selected_location_entity.dart';

abstract class SelectedLocationRepo {
  Stream<List<SelectedLocationEntity>> getLocationsStream();

  Future<String> addLocation(SelectedLocationEntity location);

  Future<void> updateLocation(SelectedLocationEntity location);

  Future<void> deleteLocation(String id);

  Future<bool> checkLocationExists(String id);
}
