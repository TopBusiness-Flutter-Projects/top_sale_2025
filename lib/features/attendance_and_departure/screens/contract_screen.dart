import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import '../../../core/utils/app_colors.dart';

class ContractScreen extends StatelessWidget {
   ContractScreen({super.key});
  List<String> titles = [
    "start_date".tr(),
    "end_date".tr(),
    "number_of_working_hours".tr(),
    "section".tr(),
    "jop".tr(),
  ];
  List<String> descriptions = [
    "12-12-2022",
    "12-12-2022",
    "8 ساعات",
    "أدارة المبيعات",
   "مندوب",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "contract".tr(),
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: false,
        backgroundColor: AppColors.white,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          Text("رقم العقد/ 123456",style: getBoldStyle(color: AppColors.primary),),
          SizedBox(height: 20.h),
          ListView.builder(
            itemBuilder: (context, index) =>  customRowContract(
              title: titles[index],
              description: descriptions[index],
            ),
            itemCount: titles.length,
            shrinkWrap: true,

          ),

        ],
      ),
    );
  }

   Column customRowContract({
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.only(left: 100.0.sp, right: 100.0.sp),
          child: Row(
            children: [
              Text(
                " $title  :",
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                description,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Divider(
          color: AppColors.black.withOpacity(0.5),
          endIndent: 30.sp,
          indent: 30.sp,
          thickness: 1,
        ),
      ],
    );
  }
}
