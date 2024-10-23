import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/features/returns/cubit/returns_cubit.dart';
import 'package:top_sale/features/returns/cubit/returns_state.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class ReturnsScreen extends StatelessWidget {
  const ReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ReturnsCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text('returns'.tr()),
        centerTitle: false,
        titleTextStyle: getBoldStyle(
          fontSize: 20.sp,
          color: AppColors.black,
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.sp),
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, Routes.deleveryOrderRoute);
          },
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),

      ),
      body: BlocBuilder<ReturnsCubit, ReturnsState>(
        builder: (context,state) {
          return Padding(
            padding:  EdgeInsets.only(left: 10.0.sp, right: 10.0.sp),
            child: Column(
              children: [
                CustomTextField(
                  controller: cubit.searchController,
                  // onChanged: cubit.onChangeSearch,
                  labelText: "search_from_user".tr(),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 35,
                    color: AppColors.gray2,
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(8.0.sp),
                              child: Container(
                                  padding: EdgeInsets.only(
                                    left: 8.0.sp,
                                    right: 8.0.sp,
                                    top: 10.0.sp,
                                    bottom: 10.0.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        color:
                                        Colors.black.withOpacity(0.1), // لون الظل مع تقليل الشفافية
                                        spreadRadius: 1, // مدى انتشار الظل
                                        blurRadius: 4, // مدى نعومة الظل
                                        offset: const Offset(0, 1), // الاتجاه الأفقي والرأسي للظل
                                      ),
                                    ],
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            " PBNK1/2024/00072".tr(),
                                            style: getBoldStyle(
                                                color: AppColors.black,
                                                fontSize: 16.sp),
                                          ), AutoSizeText(
                                            " 10/8/2024".tr(),
                                            style: getBoldStyle(
                                                color: AppColors.orange,
                                                fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Image.asset(ImageAssets.userPayment,width: 25.sp,height: 25.sp,),
                                          SizedBox(width: 10.sp,),
                                          AutoSizeText("هشام التطاوى".tr(),
                                              style: getBoldStyle(
                                                  color: AppColors.black.withOpacity(0.8),
                                                  fontSize: 14.sp)),
                                          const Spacer(),
                                          AutoSizeText("254 ج".tr(),

                                              style: getBoldStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14.sp)),
                                          const Spacer(),
                                          AutoSizeText("بنك",

                                              style: getBoldStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14.sp)),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
