import 'package:get_it/get_it.dart';
import 'package:am_adel_dashboard/core/services/storage_services.dart';
import 'database_services.dart';

final instance = GetIt.instance;

void initAppModule() {

  instance.registerLazySingleton<DatabaseServices>(() => FirestoreDatabase());
  instance.registerLazySingleton<StorageServices>(() => SupabaseStorage());
}
