import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/feature/clients/presentation/view_model/clients_cubit.dart';
import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../core/utils/config_size.dart';
import '../../../clients/presentation/widgets/statistics_card.dart';
import '../../../main/presentation/view_model/main_cubit.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:MediaQuery.sizeOf(context).width >ConfigSize.phone?
          Row(
            children: [
              Expanded(
                child: StatisticsCard(
                  model: StatisticsCardModel(
                    onTap: (){
                      context.read<MainCubit>().changeIndex(6);
                    },
                    color: Colors.green,
                    icon: Icons.people,
                    title: 'اجمالي العملاء',
                    subTitleNumber:
                        '${context.watch<ClientsCubit>().clients.length}',
                    subTitleText: 'عدد العملاء المسجلين',
                  ),
                ),
              ),
              Expanded(
                child: StatisticsCard(
                  model: StatisticsCardModel(
                    onTap: (){
                      context.read<MainCubit>().changeIndex(5);
                    },

                    color: Colors.orange,
                    icon: Icons.receipt_long_outlined,
                    title: 'اجمالي الطلبات',
                    subTitleNumber:
                        '${context.watch<ClientsCubit>().orders.length}',
                    subTitleText: 'الطلبات المنفذة',
                  ),
                ),
              ),
              Expanded(
                child: StatisticsCard(
                  model: StatisticsCardModel(
                    onTap: (){
                      context.read<MainCubit>().changeIndex(7);
                    },
                    color: Colors.purple,
                    icon: Icons.inventory_2_outlined,
                    title: 'اجمالي العروض',
                    subTitleNumber:
                    '${context.watch<OffersCubit>().offers.length}',

                    subTitleText: 'العروض المتاحة',
                  ),
                ),
              ),
              Expanded(
                child: StatisticsCard(
                  model: StatisticsCardModel(
                    color: Colors.blue,
                    icon: Icons.attach_money,
                    title: 'اجمالي المبيعات',
                    subTitleNumber: '${context.watch<OrdersCubit>().totalPriceWithDelivery}',
                    subTitleText: 'إجمالي الإيرادات',
                  ),
                ),
              ),
            ],
          ):
          Padding(
            padding: const EdgeInsets.only(top:10,right: 10,left: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatisticsCard(
                        model: StatisticsCardModel(
                          onTap: (){
                            context.read<MainCubit>().changeIndex(6);
                          },
                          color: Colors.green,
                          icon: Icons.people,
                          title: 'اجمالي العملاء',
                          subTitleNumber:
                          '${context.watch<ClientsCubit>().clients.length}',
                          subTitleText: 'عدد العملاء المسجلين',
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: StatisticsCard(
                        model: StatisticsCardModel(
                          onTap: (){
                            context.read<MainCubit>().changeIndex(5);
                          },

                          color: Colors.orange,
                          icon: Icons.receipt_long_outlined,
                          title: 'اجمالي الطلبات',
                          subTitleNumber:
                          '${context.watch<ClientsCubit>().orders.length}',
                          subTitleText: 'الطلبات المنفذة',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: StatisticsCard(
                        model: StatisticsCardModel(
                          onTap: (){
                            context.read<MainCubit>().changeIndex(7);
                          },
                          color: Colors.purple,
                          icon: Icons.inventory_2_outlined,
                          title: 'اجمالي العروض',
                          subTitleNumber:
                          '${context.watch<OffersCubit>().offers.length}',

                          subTitleText: 'العروض المتاحة',
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: StatisticsCard(
                        model: StatisticsCardModel(
                          color: Colors.blue,
                          icon: Icons.attach_money,
                          title: 'اجمالي المبيعات',
                          subTitleNumber: '${context.watch<OrdersCubit>().totalPriceWithDelivery}',
                          subTitleText: 'إجمالي الإيرادات',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
