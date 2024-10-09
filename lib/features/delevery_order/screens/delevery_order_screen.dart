import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/delevery_order/screens/widgets/drop_down_widget.dart';
import 'package:top_sale/features/delevery_order/screens/widgets/shipment_card_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../cubit/delevery_orders_cubit.dart';
import '../cubit/delevery_orders_state.dart';

class DeleveryOrderScreen extends StatelessWidget {
  const DeleveryOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DeleveryOrdersCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        leadingWidth: 20,
        title: Text(
           "delevery_order".tr(),
          style: TextStyle(
              fontFamily: AppStrings.fontFamily,
              color: AppColors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: AppColors.white,
      body: Column(
        children: [

          BlocBuilder<DeleveryOrdersCubit, DeleveryOrdersState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          cubit.changeIndex(0);
                        },
                        child: Container(
                          height: getSize(context) / 9,
                          width: getSize(context) / 2.5,
                          decoration: BoxDecoration(
                            color: cubit.currentIndex == 0
                                ? AppColors.orange
                                : AppColors.gray1,
                            borderRadius:
                                BorderRadius.circular(getSize(context) / 20),
                          ),
                          child: Center(
                            child: Text(
                              "current_orders".tr(),
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: "Tajawal",
                                color: cubit.currentIndex == 0
                                    ? AppColors.white
                                    : AppColors.grayLite,
                                fontSize: getSize(context) / 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: getSize(context) / 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          cubit.changeIndex(1);
                        },
                        child: Container(
                          height: getSize(context) / 9,
                          width: getSize(context) / 2.5,
                          decoration: BoxDecoration(
                            color: cubit.currentIndex == 1
                                ? AppColors.orange
                                : AppColors.gray1,
                            borderRadius:
                                BorderRadius.circular(getSize(context) / 20),
                          ),
                          child: Center(
                            child: Text(
                              "last_orders".tr(),
                              style: TextStyle(
                                fontFamily: "Tajawal",
                                color: cubit.currentIndex == 1
                                    ? AppColors.white
                                    : AppColors.grayLite,
                                fontSize: getSize(context) / 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: getSize(context) / 20),
          Expanded(
            child: BlocBuilder<DeleveryOrdersCubit, DeleveryOrdersState>(
              builder: (context, state) {
                return cubit.currentIndex == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DropDownMenuWidget(),
                          SizedBox(height: getSize(context) / 20),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 7, // Number of current orders
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: getSize(context) / 50,
                                      bottom: getSize(context) / 50,
                                      left: getSize(context) / 50),
                                  child: ShipmentCardWidget(
                                    backgroundColor:
                                        AppColors.orange.withOpacity(0.5),
                                    textColor: AppColors.orange,
                                    status: "new".tr(), // Current orders
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3, // Number of last orders
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(getSize(context) / 50),
                            child: ShipmentCardWidget(
                              backgroundColor: AppColors.green.withOpacity(0.5),
                              textColor: AppColors.green,
                              status: "complete".tr(), // Last orders
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
