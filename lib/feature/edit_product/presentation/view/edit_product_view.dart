import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/repos/product_repo/product_repo_impl.dart';
import 'package:am_adel_dashboard/core/repos/upload_image_repo/upload_image_repo_impl.dart';
import 'package:am_adel_dashboard/core/services/database_services.dart';
import 'package:am_adel_dashboard/core/services/storage_services.dart';

import '../../../../core/cubit/products_cubit/update_product/update_product_cubit.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../widgets/edit_product_view_body.dart';

class EditProductView extends StatelessWidget {
  final ProductEntity product;
  const EditProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UpdateProductCubit(
            ProductRepoImpl(FirestoreDatabase()),
            UploadImageRepoImpl(SupabaseStorage()),
          ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.mainColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: const CustomBackButton(),
          ),
          centerTitle: true,
          title: Text(
            'تعديل المنتج',
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(
              color: AppColor.textOnDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: EditProductViewBody(product: product,),
      ),
    );
  }
}
