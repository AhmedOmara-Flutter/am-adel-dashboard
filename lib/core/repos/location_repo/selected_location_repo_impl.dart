import 'package:am_adel_dashboard/core/repos/location_repo/selected_location_repo.dart';

import '../../entities/selected_location_entity.dart';
import '../../../../../core/models/selected_location_model.dart';
import '../../../../../core/services/database_services.dart';



class SelectedLocationRepoImpl implements SelectedLocationRepo {
  final DatabaseServices _databaseServices;

  SelectedLocationRepoImpl(this._databaseServices);

  static const String _collection = 'delivery_locations';

  @override
  Stream<List<SelectedLocationEntity>> getLocationsStream() {
    return _databaseServices
        .getStreamData(
          path: _collection,
          query: {'orderBy': 'createdAt', 'descending': false},
        )
        .map((data) {
          final List locations = data as List;

          return locations
              .map(
                (json) => SelectedLocationModel.fromJson(
                  Map<String, dynamic>.from(json),
                ).toEntity(),
              )
              .toList();
        });
  }

  @override
  Future<String> addLocation(SelectedLocationEntity location) async {
    final model = SelectedLocationModel.fromEntity(location);

    return await _databaseServices.addData(
      path: _collection,
      data: model.toJson(),
    );
  }

  @override
  Future<void> updateLocation(SelectedLocationEntity location) async {
    final model = SelectedLocationModel.fromEntity(location);

    await _databaseServices.updateData(
      path: _collection,
      docId: location.id,
      data: model.toJson(),
    );
  }

  @override
  Future<void> deleteLocation(String id) async {
    await _databaseServices.deleteData(path: _collection, uId: id);
  }

  @override
  Future<bool> checkLocationExists(String id) async {
    return await _databaseServices.checkExists(path: _collection, uId: id);
  }
}
