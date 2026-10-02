import 'package:am_adel_dashboard/core/utils/app_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NetworkCubit()),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => ClientsCubit(instance(), instance())),
        BlocProvider(
          create: (context) => GetProductWithReviewsCubit(instance()),),
        BlocProvider(create: (context) => GetReviewsCubit(instance()),),
        BlocProvider(create: (context) => CategoryCubit(instance()),),
        BlocProvider(create: (context) => ProductsCubit(instance()),),
        BlocProvider(
          create: (context) => OffersCubit(instance(), instance(),),),
        BlocProvider(create: (context) => OrdersCubit(instance()),),
        BlocProvider(create: (_) =>
        SettingsCubit(instance())
          ..getRestaurantStatus(),),
        BlocProvider(create: (context) => DeleteBundleOfferCubit(instance()),),
        BlocProvider(create: (_) => CartStatusCubit(instance()),),
        BlocProvider(create: (context) =>
            DailyReportsCubit(instance(), context.read<OrdersCubit>(),),),
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
                    child:
                    (state is NetworkDisconnected ||
                        state is NetworkLoading)
                        ? const NoInternetView()
                        : const SizedBox.shrink(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
