import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/view/add_product_view.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/view/clients_view.dart';
import 'package:am_adel_dashboard/feature/daily_reports/presentation/view/reports_view.dart';
import 'package:am_adel_dashboard/feature/main/presentation/widgets/drawer_item.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/view/my_products_view.dart';
import 'package:am_adel_dashboard/feature/orders/presentation/view/order_view.dart';
import 'package:am_adel_dashboard/feature/send_notification/view/notification_hub_view.dart';

import '../../../admin/presentation/view/admin_view.dart';
import '../../../bundle_offer/presentation/view/bundle_offer_view.dart';
import '../../../category/presentation/view/category_view.dart';
import '../../../daily_reports/presentation/view/daily_reports_view.dart';
import '../../../offers/presentation/view/offers_view.dart';
import '../../../reviews/presentation/view/reviews_view.dart';
import '../../../selected_location/view/selected_location_view.dart';
import '../../../send_notification/view/send_notification_view.dart';
import '../../../settings/presentation/view/settings_view.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  int selectedIndex = 0;

  final List<DrawerItemModel> drawerItems = [
    DrawerItemModel(
      title: 'الصفحه الرئيسيه',
      inactiveIcon: Icons.home_outlined,
      activeIcon: Icons.home_filled,
    ),
    DrawerItemModel(
      title: 'التصنيفات',
      inactiveIcon: Icons.category_outlined,
      activeIcon: Icons.category,
    ),
    DrawerItemModel(
      title: 'المنتجات',
      inactiveIcon: Icons.category_outlined,
      activeIcon: Icons.category_rounded,
    ),
    DrawerItemModel(
      title: 'اضافه منتج',
      inactiveIcon: Icons.add,
      activeIcon: Icons.add,
    ),
    DrawerItemModel(
      title: 'آراء العملاء',
      inactiveIcon: Icons.star_border_rounded,
      activeIcon: Icons.star,
    ),
    DrawerItemModel(
      title: 'الطلبات',
      inactiveIcon: Icons.local_shipping_outlined,
      activeIcon: Icons.local_shipping,
    ),
    DrawerItemModel(
      title: 'العملاء',
      inactiveIcon: Icons.people_alt_outlined,
      activeIcon: Icons.people,
    ),
    DrawerItemModel(
      title: 'العروض',
      inactiveIcon: Icons.local_offer_outlined,
      activeIcon: Icons.local_offer,
    ),
    DrawerItemModel(
      title: 'باكدج',
      inactiveIcon: Icons.inventory_2_outlined,
      activeIcon: Icons.inventory_2_rounded,
    ),
    DrawerItemModel(
      title: 'التوصيل',
      inactiveIcon: Icons.location_on_outlined,
      activeIcon: Icons.location_on,
    ),
    DrawerItemModel(
      title: 'الاشعارات',
      inactiveIcon: Icons.notification_important_outlined,
      activeIcon: Icons.notification_important,
    ),
    DrawerItemModel(
      title: 'الجرد',
      inactiveIcon: Icons.store_mall_directory_outlined,
      activeIcon: Icons.store_mall_directory,
    ),
    DrawerItemModel(
      title: 'الاعدادات',
      inactiveIcon: Icons.settings_outlined,
      activeIcon: Icons.settings,
    ),
  ];

  final List<Widget> screens = [
    AdminView(),
    CategoryView(),
    MyProductsView(),
    AddProductView(),
    ReviewsView(),
    OrderView(),
    ClientsView(),
    OffersView(),
    BundleOfferView(),
    SelectedLocationView(),
    NotificationsHubView(),
    ReportsView(),
    SettingsView(),
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    emit(MainChangeIndex());
  }
}
