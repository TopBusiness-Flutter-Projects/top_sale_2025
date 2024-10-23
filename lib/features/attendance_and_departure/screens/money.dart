import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';

import '../../../config/routes/app_routes.dart';

class MoneyScreen extends StatelessWidget {
  const MoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          titleTextStyle: getBoldStyle(color: AppColors.black, fontSize: 20.sp),
          centerTitle: false,
          title: Text("the_money".tr()),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.moneyTypeRoute);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary),
            height: 50.h,
            width: 130.w,
            child: Center(
              child: Text(
                "add_money".tr(),
                style: getBoldStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                          left: 8.0.sp, right: 8.0.sp, bottom: 2.0.sp),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 8.sp, right: 8.sp, top: 10.sp, bottom: 10.sp),
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              color: Colors.black.withOpacity(
                                  0.1), // لون الظل مع تقليل الشفافية
                              spreadRadius: 1, // مدى انتشار الظل
                              blurRadius: 4, // مدى نعومة الظل
                              offset: const Offset(
                                  0, 1), // الاتجاه الأفقي والرأسي للظل
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.sp, vertical: 5.sp),
                                  decoration: BoxDecoration(
                                    color: AppColors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16.sp),
                                  ),
                                  child: Text(
                                    'مقبول',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '10/8/2024',
                                  style: TextStyle(
                                    color: AppColors.orange,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.sp),
                            Text(
                              'PBNK1/2024/00072',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'بنك',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '254 ج',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'بترين العربية',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))
          ],
        )
    );
  }
}
