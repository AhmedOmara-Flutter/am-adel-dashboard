import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/repos/product_repo/product_repo_impl.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/add_product_view_body.dart';
import 'package:am_adel_dashboard/feature/main/presentation/view_model/main_cubit.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../core/repos/upload_image_repo/upload_image_repo_impl.dart';
import '../../../../core/services/database_services.dart';
import '../../../../core/services/storage_services.dart';
import '../view_model/add_product_cubit.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) =>
            AddProductCubit(
              ProductRepoImpl(
                  FirestoreDatabase()),
              UploadImageRepoImpl(SupabaseStorage()),
            ),

        child: AddProductViewBody()
    );
  }
}
