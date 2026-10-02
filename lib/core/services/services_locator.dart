import 'package:am_adel_dashboard/feature/clients/data/repos/clients_repo_impl.dart';
import 'package:am_adel_dashboard/feature/clients/domain/repos/clients_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:am_adel_dashboard/core/services/storage_services.dart';
import '../../feature/cart_status/data/repos/cart_status_repo.dart';
import '../../feature/cart_status/domain/repos/cart_status_repo_impl.dart';
import '../../feature/category/data/repos/category_repo.dart';
import '../../feature/category/domain/repos/category_repo_impl.dart';
import '../../feature/daily_reports/data/repos/daily_report_repo.dart';
import '../../feature/daily_reports/domain/repos/daily_report_repo_impl.dart';
import '../../feature/settings/data/repos/settings_repo.dart';
import '../../feature/settings/domain/repos/settings_repo_impl.dart';
import '../repos/bundle_offer_repo/bundle_offer_repo.dart';
import '../repos/bundle_offer_repo/bundle_offer_repo_impl.dart';
import '../repos/offer_repo/offer_repo.dart';
import '../repos/offer_repo/offer_repo_impl.dart';
import '../repos/orders_repo/orders_repo.dart';
import '../repos/product_repo/product_repo.dart';
import '../repos/product_repo/product_repo_impl.dart';
import '../repos/reviews_repo/review_repo.dart';
import '../repos/reviews_repo/review_repo_impl.dart';
import 'database_services.dart';

final instance = GetIt.instance;

void initAppModule() {
  instance.registerLazySingleton<DatabaseServices>(() => FirestoreDatabase());
  instance.registerLazySingleton<StorageServices>(() => SupabaseStorage());
  instance.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(instance()),);
  instance.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(instance()),);
  instance.registerLazySingleton<OfferRepo>(() => OfferRepoImpl(instance()));
  instance.registerLazySingleton<OrdersRepo>(() => OrdersRepoImpl(instance()));
  instance.registerLazySingleton<BundleOfferRepo>(() => BundleOfferRepoImpl(instance()),);
  instance.registerLazySingleton<ReviewRepo>(() => ReviewRepoImpl(instance()));
  instance.registerLazySingleton<CartStatusRepo>(() => CartStatusRepoImpl(instance()),);
  instance.registerLazySingleton<SettingsRepo>(() => SettingsRepoImpl(instance()),);
  instance.registerLazySingleton<DailyReportRepo>(() => DailyReportRepoImpl(instance()),);
  instance.registerLazySingleton<ClientsRepo>(() => ClientsRepoImpl(instance()),);
}
