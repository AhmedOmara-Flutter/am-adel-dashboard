import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/config_size.dart';
import '../../../../generated/assets.dart';
import '../view_model/main_cubit.dart';
import '../widgets/custom_drawer.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit,MainState>(
  builder: (context, state) {
    final cubit=context.read<MainCubit>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(width:250,child: CustomDrawer()),
      appBar: MediaQuery.sizeOf(context).width <= ConfigSize.phone? AppBar(
        title: Text(
          cubit.drawerItems[cubit.selectedIndex].title,
          style: Theme
              .of(context)
              .textTheme
              .displaySmall!
              .copyWith(
              color: Colors.white
          ),
        ),
       centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu,color: Colors.white,),
        ),
        automaticallyImplyLeading: false,
        backgroundColor:AppColor.background,
      ):null,

    body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            final cubit = context.read<MainCubit>();
            if (cubit.selectedIndex != 0) {
              cubit.changeIndex(0);
            } else {
              SystemNavigator.pop();
            }
          },
        child:MediaQuery.sizeOf(context).width >ConfigSize.phone? Row(
          children: [
            const SizedBox(
              width: 280,
              child: CustomDrawer(),
            ),
            Expanded(
              child: IndexedStack(
                index: cubit.selectedIndex,
                children: cubit.screens,
              ),
            ),
          ],
        ): IndexedStack(
          index: cubit.selectedIndex,
          children: cubit.screens,
        ),
      ),
    );
  },
);
  }
}
