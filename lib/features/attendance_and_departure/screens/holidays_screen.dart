import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';

import '../../../core/utils/app_fonts.dart';

class HolidaysScreen extends StatelessWidget {
  const HolidaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "Holidays".tr(),
          style: getBoldStyle(fontSize: 20.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: ListView(
          children: [
            HolidayRequestCard(
              status: "جديدة", // New
              statusColor: Colors.blue,
              requestDate: "14 aug 2024",
              leaveType: "إجازة مرضية", // Sick leave
              startDate: "14 aug 2024",
              endDate: "16 aug 2024",
              notes: "",
              leaveDays: 0,
            ),
            SizedBox(height: 16.h),
            HolidayRequestCard(
              status: "مقبولة", // Approved
              statusColor: Colors.green,
              requestDate: "14 aug 2024",
              leaveType: "إجازة مرضية", // Sick leave
              startDate: "14 aug 2024",
              endDate: "16 aug 2024",
              notes: "ملاحظات الإجازة هنا", // Notes
              leaveDays: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class HolidayRequestCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String requestDate;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String notes;
  final int leaveDays;

  const HolidayRequestCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.requestDate,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    this.notes = "",
    this.leaveDays = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: AppColors.white,
borderRadius: BorderRadiusDirectional.circular(8),
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
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'holiday_request'.tr(), // Holiday Request
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                StatusBadge(status: status, color: statusColor),

              ],
            ),
            SizedBox(height: 4.h),
            Text(
              requestDate,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 8.h),
            Text(
              '$leaveType من $startDate الى $endDate',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            if (notes.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    notes,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                ],
              ),
            if (leaveDays > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    '   ${"number_of_leave_days".tr()} : $leaveDays " + " : " ' ,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  final Color color;

  const StatusBadge({super.key, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
