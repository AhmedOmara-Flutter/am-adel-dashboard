
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/cubit/network_cubit/network_cubit.dart';

import '../utils/app_color.dart';
import '../utils/style_manager.dart';
import 'custom_button.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.background,
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -70,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.mainColor.withOpacity(.08),
              ),
            ),
          ),

          Positioned(
            bottom: -120,
            left: -70,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.accentColor.withOpacity(.05),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        color: AppColor.card,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.mainColor, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.mainColor.withOpacity(.2),
                            blurRadius: 25,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.wifi_off_rounded,
                        size: 70,
                        color: AppColor.mainColor,
                      ),
                    ),

                    const SizedBox(height: 35),

                    Text(
                      "لا يوجد اتصال بالإنترنت",
                      style: StyleManager.font19Weight700(context).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "تأكد من اتصالك بالإنترنت ثم حاول مرة أخرى",
                      textAlign: TextAlign.center,
                      style: StyleManager.font13Weight400(context).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: BlocBuilder<NetworkCubit, NetworkState>(
                        builder: (context, state) {
                          return CustomButton(
                            onPressed: state is NetworkLoading
                                ? null
                                : () {
                                    context
                                        .read<NetworkCubit>()
                                        .checkConnection();
                                  },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: state is NetworkLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "إعادة المحاولة",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    BlocBuilder<NetworkCubit, NetworkState>(
                      builder: (context, state) {
                        if (state is NetworkDisconnected) {
                          return Text(
                            "سيتم إعادة الاتصال تلقائياً عند توفر الشبكة.",
                            textAlign: TextAlign.center,
                            style: StyleManager.font11Weight400(context).copyWith(
                              color: AppColor.textSecondary,
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
