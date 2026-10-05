import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/repos/upload_image_repo/upload_image_repo_impl.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/core/services/storage_services.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import '../../../../core/widgets/custom_floating_action_button.dart';
import '../../domain/repo/flash_offer_repo_impl.dart';
import '../view_model/add_flash_offer_cubit/add_flash_offer_cubit.dart';
import '../view_model/get_flash_offer_cubit/get_flash_offer_cubit.dart';
import '../widgets/add_flash_offer_bottom_sheet.dart';
import '../widgets/flash_offer_view_body.dart';

class FlashOfferView extends StatelessWidget {
  const FlashOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetFlashOfferCubit(
        FlashOfferRepoImpl(
          FirestoreDatabase(),
        ),
      )..getFlashOffers(),
      child: Scaffold(
        floatingActionButton: CustomFloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColor.background,
              builder: (_) {
                return BlocProvider(
                  create: (_) => AddFlashOfferCubit(
                    FlashOfferRepoImpl(
                      FirestoreDatabase(),
                    ),
                    UploadImageRepoImpl(
                      SupabaseStorage(),
                    ),
                  ),
                  child: const AddFlashOfferBottomSheet(),
                );
              },
            );
          },
        ),
        body: const FlashOfferViewBody(),
      ),
    );
  }
}