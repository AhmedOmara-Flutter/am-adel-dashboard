import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:am_adel_dashboard/core/cubit/network_cubit/network_cubit.dart';
import 'package:am_adel_dashboard/core/repos/orders_repo/orders_repo.dart';
import 'package:am_adel_dashboard/core/repos/reviews_repo/review_repo_impl.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/core/utils/theme_manager.dart';
import 'package:am_adel_dashboard/feature/category/presentation/view_model/category_cubit.dart';
import 'package:am_adel_dashboard/feature/clients/data/repos/clients_repo_impl.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/view_model/clients_cubit.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/view_model/get_products_with_review/get_product_with_reviews_cubit.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/view_model/get_reviews/get_reviews_cubit.dart';

import '../../feature/bundle_offer/presentation/view_model/delete_bundle_offer_cubit/delete_bundle_offer_cubit.dart';
import '../../feature/cart_status/domain/repos/cart_status_repo_impl.dart';
import '../../feature/cart_status/presentation/view_model/cart_status_cubit.dart';
import '../../feature/category/domain/repos/category_repo_impl.dart';
import '../../feature/daily_reports/domain/repos/daily_report_repo_impl.dart';
import '../../feature/daily_reports/presentation/view_model/daily_reports_cubit.dart';
import '../../feature/main/presentation/view_model/main_cubit.dart';
import '../../feature/settings/domain/repos/settings_repo_impl.dart';
import '../../feature/settings/presentation/view_model/settings_cubit.dart';
import '../../generated/l10n.dart';
import '../cubit/offers_cubit/offers_cubit.dart';
import '../cubit/orders_cubit/orders_cubit.dart';
import '../cubit/products_cubit/products_cubit.dart';
import '../repos/bundle_offer_repo/bundle_offer_repo_impl.dart';
import '../repos/offer_repo/offer_repo_impl.dart';
import '../repos/product_repo/product_repo_impl.dart';
import '../utils/route_manager.dart';
import '../widgets/no_internet_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(create: (context) =>NetworkCubit()),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) =>
            ClientsCubit(ClientsRepoImpl(FirestoreDatabase()),
              OrdersRepoImpl(FirestoreDatabase()),
            )),
        BlocProvider(create: (context) =>
            GetProductWithReviewsCubit(ReviewRepoImpl(FirestoreDatabase()))),
        BlocProvider(create: (context) =>
            GetReviewsCubit(ReviewRepoImpl(FirestoreDatabase()))),
        BlocProvider(create: (context) =>
            CategoryCubit(CategoryRepoImpl(FirestoreDatabase()))),
        BlocProvider(create: (context) =>
            ProductsCubit(ProductRepoImpl(
              FirestoreDatabase(),
            ))),
        BlocProvider(create: (context) =>
            OffersCubit(OfferRepoImpl(FirestoreDatabase()),
                ProductRepoImpl(FirestoreDatabase()))),
        BlocProvider(create: (context) =>
            OrdersCubit(OrdersRepoImpl(FirestoreDatabase()))),
        BlocProvider(
          create: (_) =>
          SettingsCubit(
            SettingsRepoImpl(FirestoreDatabase()),
          )
            ..getRestaurantStatus(),),
        BlocProvider(create: (context) =>
            DeleteBundleOfferCubit(BundleOfferRepoImpl(FirestoreDatabase())),
        ),
        BlocProvider(
          create: (_) =>
              CartStatusCubit(
                cartStatusRepo: CartStatusRepoImpl(
                  databaseServices: FirestoreDatabase(),
                ),
              ),),
        BlocProvider<DailyReportsCubit>(
          create: (context) => DailyReportsCubit(
            DailyReportRepoImpl(
              FirestoreDatabase(),
            ),
            context.read<OrdersCubit>(),
          ),
        ),

      ],

        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeManager.darkTheme(context),
          onGenerateRoute: GenerateRoute.generateRoute,
          initialRoute: RouteManager.splash,
          builder: (context, child) {
            return BlocBuilder<NetworkCubit, NetworkState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    child!,
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: (state is NetworkDisconnected || state is NetworkLoading)
                          ? const NoInternetView()
                          : const SizedBox.shrink(),
                    ),                    ],
                );
              },
            );
          },
        )
    );
  }
}