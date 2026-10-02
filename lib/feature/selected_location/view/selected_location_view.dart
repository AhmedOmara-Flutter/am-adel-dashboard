import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/repos/location_repo/selected_location_repo_impl.dart';
import '../../../core/services/database_services.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/custom_floating_action_button.dart';
import '../view_model/selected_location_cubit.dart';
import '../widgets/add_location_bottom_sheet.dart';
import '../widgets/selected_location_view_body.dart';

class SelectedLocationView extends StatelessWidget {
  const SelectedLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SelectedLocationCubit(SelectedLocationRepoImpl(FirestoreDatabase()))
            ..getLocations(),
      child: Scaffold(
        backgroundColor: AppColor.background,
        floatingActionButton: CustomFloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColor.background,
              builder: (_) {
                return BlocProvider(
                  create: (_) => SelectedLocationCubit(
                    SelectedLocationRepoImpl(
                      FirestoreDatabase(),
                    ),
                  ),
                  child: const AddLocationBottomSheet(),
                );
              },
            );
          },
        ),
        body: const SelectedLocationViewBody(),
      ),
    );
  }
}
