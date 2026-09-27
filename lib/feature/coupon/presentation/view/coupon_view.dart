import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repos/coupon_repo_impl.dart';
import '../view_model/add_coupon_cubit/add_coupon_cubit.dart';
import '../view_model/delete_coupon_cubit/delete_coupon_cubit.dart';
import '../view_model/get_coupon_cubit/get_coupon_cubit.dart';
import '../widgets/add_coupon_bottom_sheet.dart';
import '../widgets/coupon_view_body.dart';

class CouponView extends StatelessWidget {
  const CouponView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              GetCouponCubit(CouponRepoImpl(FirestoreDatabase()))..getCoupons(),
        ),
        BlocProvider(
          create: (_) => DeleteCouponCubit(CouponRepoImpl(FirestoreDatabase())),
        ),
      ],
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FloatingActionButton(
                heroTag: null,
                backgroundColor: AppColor.mainColor,
                shape: const CircleBorder(),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColor.background,
                    builder: (_) {
                      return BlocProvider(
                        create: (_) =>
                            AddCouponCubit(CouponRepoImpl(FirestoreDatabase())),
                        child: const AddCouponBottomSheet(),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add, color: AppColor.white),
              ),
            ],
          ),
        ),
        body: const CouponViewBody(),
      ),
    );
  }
}
