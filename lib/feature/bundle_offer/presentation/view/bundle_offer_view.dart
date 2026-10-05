import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:am_adel_dashboard/feature/bundle_offer/domain/repos/bundle_offer_repo_impl.dart';
import 'package:am_adel_dashboard/core/repos/upload_image_repo/upload_image_repo_impl.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/core/services/storage_services.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import '../../../../core/widgets/custom_floating_action_button.dart';
import '../view_model/add_bundle_offer_cubit/add_bundle_offer_cubit.dart';
import '../view_model/get_bundle_offer_cubit/get_bundle_offer_cubit.dart';
import '../widgets/add_bundle_offer_bottom_sheet.dart';
import '../widgets/bundle_offer_view_body.dart';

class BundleOfferView extends StatelessWidget {
  const BundleOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetBundleOfferCubit(
        BundleOfferRepoImpl(
          FirestoreDatabase(),
        ),
      )..getBundleOffers(),
      child: Scaffold(
        floatingActionButton: CustomFloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColor.background,
              builder: (_) {
                return BlocProvider(
                  create: (_) => AddBundleOfferCubit(
                    BundleOfferRepoImpl(
                      FirestoreDatabase(),
                    ),
                    UploadImageRepoImpl(
                      SupabaseStorage(),
                    ),
                  ),
                  child: const AddBundleOfferBottomSheet(),
                );
              },
            );
          },
        ),        body: const BundleOfferViewBody(),
      ),
    );
  }
}