import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/features/attendance_and_departure/screens/widgets/advence_and_salaries_widget.dart';
import 'package:top_sale/features/attendance_and_departure/screens/widgets/attendance_and_departure_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';

class AttendanceAndDepartureScreen extends StatelessWidget {
  const AttendanceAndDepartureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        title: Text(
          "attendance_and_departure".tr(),
          style: getBoldStyle(fontSize: 20.sp),
        ),
      ),
      body: Column(
        children: [
          const ContainerTimesFromUserInHomeScreen(),
          SizedBox(height: 20.h),
          // Display advances and salaries widget
           AdvanceAndSalariesWidget(),

        ],
      )
    );
  }
}
