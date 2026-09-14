import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:am_adel_dashboard/core/entities/order_entity.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/feature/daily_reports/presentation/view/daily_reports_view.dart';
import 'package:am_adel_dashboard/feature/send_notification/view/send_notification_for_each_user.dart';
import 'package:am_adel_dashboard/feature/send_notification/view/send_notification_view.dart';

import '../../feature/add_product/presentation/view/add_product_view.dart';
import '../../feature/display_order/presentation/view/display_orders_view.dart';
import '../../feature/edit_product/presentation/view/edit_product_view.dart';
import '../../feature/main/presentation/view/main_view.dart';
import '../../feature/order_details/presentation/view/order_details_view.dart';
import '../../feature/reviews/presentation/view/product_reviews.dart';
import '../../feature/splash/view/splash_view.dart';

class RouteManager {
  static const String splash = '/splashView';
  static const String main = '/mainView';
  static const String addProductView = '/addProductView';
  static const String displayOrders = '/displayOrdersView';
  static const String productReviews = '/productReviewsView';
  static const String editProductView = '/editProductView';
  static const String orderDetails = '/orderDetailsView';
  static const String sendNotification = '/sendNotificationView';
  static const String dailyReportView = '/dailyReportView';
  static const String sendNotificationForEachUser = '/sendNotificationForEachUser';

}

class GenerateRoute {
  static Route<dynamic> _route(Widget child) {
    return PageTransition(
      child: child,
      type: PageTransitionType.fade,
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.splash:
        return _route(const SplashView());

      case RouteManager.main:
        return _route(const MainView());

        case RouteManager.dailyReportView:
        return _route(const DailyReportView());

      case RouteManager.addProductView:
        return _route(const AddProductView());

      case RouteManager.sendNotification:
        return _route(const SendNotificationView());

      case RouteManager.sendNotificationForEachUser:
        return _route(const SendNotificationForEachUser());

      case RouteManager.displayOrders:
        final orders = settings.arguments as List<OrderEntity>;
        return _route(
          DisplayOrdersView(
            orders: orders,
          ),
        );

      case RouteManager.orderDetails:
        final args = settings.arguments as Map<String, dynamic>;

        final order = args['order'] as OrderEntity;
        final orderNumber = args['orderNumber'] as int;

        return _route(
          OrderDetailsView(
            order: order,
            orderNumber: orderNumber,
          ),
        );

      case RouteManager.productReviews:
        final product = settings.arguments as ProductEntity;
        return _route(
          ProductReviewsView(
            product: product,
          ),
        );

      case RouteManager.editProductView:
        final product = settings.arguments as ProductEntity;
        return _route(
          EditProductView(
            product: product,
          ),
        );

      default:
        return _route(
          Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: AppColor.background,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 70,
                          color: AppColor.mainColor,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'حدثت مشكلة',
                          style: StyleManager.font23Weight700(context).copyWith(
                            color: AppColor.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'تعذر فتح الصفحة المطلوبة.\nيرجى إعادة المحاولة مرة أخرى.',
                          textAlign: TextAlign.center,
                          style: StyleManager.font14Weight600(context).copyWith(
                            color: AppColor.textSecondary,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
    }
  }
}