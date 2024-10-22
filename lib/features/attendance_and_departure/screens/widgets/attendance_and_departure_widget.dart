import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

class ContainerTimesFromUserInHomeScreen extends StatefulWidget {
  const ContainerTimesFromUserInHomeScreen(
      {super.key});
  @override
  State<ContainerTimesFromUserInHomeScreen> createState() =>
      _ContainerTimesFromUserInHomeScreenState();
}

class _ContainerTimesFromUserInHomeScreenState
    extends State<ContainerTimesFromUserInHomeScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

        return Padding(
          padding:  EdgeInsets.only(top: 20.sp, left: 20.sp, right: 20.sp, bottom: 20.sp),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color:
                  Colors.black.withOpacity(0.1), // لون الظل مع تقليل الشفافية
                  spreadRadius: 2, // مدى انتشار الظل
                  blurRadius: 4, // مدى نعومة الظل
                  offset: const Offset(0, 1), // الاتجاه الأفقي والرأسي للظل
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15.h),
                    child: Table(
                      // defaultColumnWidth: const FixedColumnWidth(110.0),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.gray1),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0.h),
                              child: Column(
                                children: [
                                  AutoSizeText(
                                    "attendance_time".tr(),
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0.h),
                              child: Column(
                                children: [
                                  AutoSizeText(
                                    "work_time".tr(),
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0.h),
                              child: Column(
                                children: [
                                  AutoSizeText(
                                    "dismissal_time".tr(),
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: Column(
                                children: [
                                  Text(

                                        '00:00',
                                    style: TextStyle(
                                      fontSize: 20.0.sp,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: Column(
                                children: [
                                  Text("00:00",
                                    style: TextStyle(
                                      fontSize: 20.0.sp,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: Column(
                                children: [
                                  Text(

                                        '00:00',
                                    style: TextStyle(
                                      fontSize: 20.0.sp,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                 SizedBox(height: 20.h,),
                  isLoading
                      ? Padding(
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: Padding(
                            padding: EdgeInsets.only(left: 25.w, right: 25.w),
                            child: Container(
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:AppColors.primary

                                ),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.white,
                                ))),
                          ))
                      : GestureDetector(
                          onTap: () {





                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 25.w, right: 25.w),
                            child: Container(
                              height: 40.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.black,
                              ),
                              child: Center(
                                child: Text(
                                  'attendance'.tr(),
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 20.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        );

  }
}

String calculateTimeDifference(String givenTime) {
  if (givenTime == "00:00") {
    return "00:00";
  }
  DateTime now = DateTime.now();
  DateFormat format = DateFormat.Hm('en');
  DateTime givenDateTime = format.parse(givenTime);
  DateTime todayGivenTime = DateTime(
      now.year, now.month, now.day, givenDateTime.hour, givenDateTime.minute);
  if (todayGivenTime.isBefore(now)) {
    Duration difference = now.difference(todayGivenTime);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  } else {
    Duration difference = todayGivenTime.difference(now);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}