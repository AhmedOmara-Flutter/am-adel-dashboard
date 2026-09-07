import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/widgets/custom_text_field.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/category_tabs.dart';

import '../../../../core/cubit/products_cubit/products_cubit.dart';

class MyProductsViewBody extends StatefulWidget{
  const MyProductsViewBody({super.key});

  @override
  State<MyProductsViewBody> createState() => _MyProductsViewBodyState();
}

class _MyProductsViewBodyState extends State<MyProductsViewBody> {
  @override
  void initState() {
    context.read<ProductsCubit>().getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: CategoryTabs()),
      ],
    );
  }
}
