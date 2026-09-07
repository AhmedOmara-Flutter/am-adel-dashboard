import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../generated/assets.dart';
import '../../../core/utils/style_manager.dart';
import '../view_model/selected_location_cubit.dart';
import 'edit_location_bottom_sheet.dart';
import 'selected_location_card.dart';

class SelectedLocationViewBody extends StatelessWidget {
  const SelectedLocationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedLocationCubit, SelectedLocationState>(
      builder: (context, state) {
        if (state is SelectedLocationGetLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.mainColor,
              strokeWidth: 2,
            ),
          );
        }

        if (state is SelectedLocationGetError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: AppColor.red,
              ),
            ),
          );
        }

        final locations =
            context.read<SelectedLocationCubit>().locations;

        if (locations.isEmpty) {
          return Center(
            child: Lottie.asset(
              Assets.assets.json.empty,
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: locations.length,
          separatorBuilder: (_, __) {
            return const SizedBox(height: 14);
          },
          itemBuilder: (context, index) {
            final location = locations[index];

            return SelectedLocationCard(
              location: location,
              onEdit: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColor.background,
                  builder: (_) {
                    return BlocProvider.value(
                      value: context.read<SelectedLocationCubit>(),
                      child: EditLocationBottomSheet(
                        location: location,
                      ),
                    );
                  },
                );
              },
              onDelete: () {
                CustomShowDialog.show(
                  context,
                  title: 'حذف منطقة التوصيل',
                  content: Text(
                    'هل أنت متأكد أنك تريد حذف "${location.title}"؟',
                    textAlign: TextAlign.center,
                    style: StyleManager.font13Weight600(context),
                  ),
                  cancel: () {
                    Navigator.pop(context);
                  },
                  accept: () async {
                    Navigator.pop(context);

                    await context
                        .read<SelectedLocationCubit>()
                        .deleteLocation(
                      location.id,
                    );
                  },
                  flag: Icons.location_on_outlined,
                  color: AppColor.red,
                );
              },
            );
          },
        );
      },
    );
  }
}