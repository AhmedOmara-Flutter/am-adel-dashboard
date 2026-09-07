import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/database_services.dart';
import '../../../../core/utils/app_color.dart';
import '../../domain/repos/category_repo_impl.dart';
import '../view_model/category_cubit.dart';
import '../widgets/add_category_bottom_sheet.dart';
import '../widgets/category_view_body.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CategoryCubit(CategoryRepoImpl(FirestoreDatabase()))..getCategories(),

      child: Scaffold(
        backgroundColor: AppColor.background,

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
                        create: (_) => CategoryCubit(
                          CategoryRepoImpl(FirestoreDatabase()),
                        ),
                        child: const AddCategoryBottomSheet(),
                      );
                    },
                  );
                },

                child: const Icon(Icons.add, color: AppColor.white),
              ),
            ],
          ),
        ),

        body: const CategoryViewBody(),
      ),
    );
  }
}
