import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/cubit/products_cubit/products_cubit.dart';
import '../../../../core/utils/app_color.dart';
import '../../../bundle_offer/presentation/view_model/delete_bundle_offer_cubit/delete_bundle_offer_cubit.dart';
import 'build_danger_card.dart';

Widget buildOrdersDangerCard(BuildContext context) {
  return DangerCard(
    title: "حذف الطلبات",
    description: "حذف جميع الطلبات نهائيًا.",
    buttonText: "حذف كل الطلبات",
    icon: Icons.warning_amber_rounded,
    color: AppColor.red,
    dialogTitle: "تأكيد حذف الطلبات",
    dialogContent: "هل أنت متأكد أنك تريد حذف كل الطلبات؟",
    dialogIcon: Icons.warning_amber_rounded,
    onPressed: () {
      context.read<OrdersCubit>().deleteOrderCollection();
    },
  );
}

Widget buildCartDangerCard(BuildContext context) {
  return DangerCard(
    title: "مسح السلة",
    description: "مسح جميع منتجات السلة نهائيًا.",
    buttonText: "مسح السلة",
    icon: Icons.shopping_cart_outlined,
    color: AppColor.accentColor,
    dialogTitle: "تأكيد مسح السلة",
    dialogContent: "هل أنت متأكد أنك تريد حذف كل محتويات السلة؟",
    dialogIcon: Icons.remove_shopping_cart,
    onPressed: () {
      context.read<ProductsCubit>().deleteCartCollectionForUser();
    },
  );
}

Widget buildBundleOffersDangerCard(BuildContext context) {
  return DangerCard(
    title: "حذف الباكدج",
    description: "حذف جميع الباكدج نهائيًا.",
    buttonText: "حذف جميع الباكدج",
    icon: Icons.inventory_2_outlined,
    color: AppColor.purple,
    dialogTitle: "تأكيد حذف جميع الباكدج",
    dialogContent: "هل أنت متأكد أنك تريد حذف جميع الباكدج؟",
    dialogIcon: Icons.inventory_2_outlined,
    onPressed: () {
      context.read<DeleteBundleOfferCubit>().deleteAllBundleOffers();
    },
  );
}

Widget buildOffersDangerCard(BuildContext context) {
  return DangerCard(
    title: "حذف العروض",
    description: "حذف جميع العروض نهائيًا.",
    buttonText: "حذف كل العروض",
    icon: Icons.local_offer_outlined,
    color: AppColor.green,
    dialogTitle: "تأكيد حذف العروض",
    dialogContent: "هل أنت متأكد أنك تريد حذف جميع العروض؟",
    dialogIcon: Icons.local_offer_outlined,
    onPressed: () {
      context.read<OffersCubit>().deleteAllOffers();
    },
  );
}