import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';

class AttendanceAndDepartureDetailsScreen extends StatelessWidget {
  const AttendanceAndDepartureDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        titleTextStyle: getBoldStyle(fontSize: 20.sp),
        title: Text('attendance_and_departure_details'.tr()),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date pickers
            const Row(

              children: [
                Expanded(child: DatePickerField(label: 'من', selectedDate: '23/2/2024')),
                SizedBox(width: 20),
                Expanded(child: DatePickerField(label: 'إلى', selectedDate: '23/2/2024'),
                )
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView(
                children: [
                  const AttendanceCard(
                    day: "الأحد",
                    date: "2/9/2024",
                    checkInTime: "09:00",
                    checkOutTime: "15:00",
                    workTime: "06:00",
                    additionalTime: "03:00",
                    departureLocation: "المنوفية",
                  ),
                  SizedBox(height: 16.h),
                  const AttendanceCard(
                    day: "الأحد",
                    date: "2/9/2024",
                    checkInTime: "09:00",
                    checkOutTime: "15:00",
                    workTime: "06:00",
                    additionalTime: "03:00",
                    departureLocation: "المنوفية",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatePickerField extends StatefulWidget {
  final String label;
  final String selectedDate;

  const DatePickerField(
      {super.key, required this.label, required this.selectedDate});

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late String _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate; // Initialize with the default value
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default date is today
      firstDate: DateTime(2000), // Minimum date
      lastDate: DateTime(2100), // Maximum date
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp),
          child: Text(widget.label,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 4.h),
        GestureDetector(
          onTap: () => _selectDate(context), // Call the date picker on tap
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                SizedBox(width: 8.w),
                Text(
                  _selectedDate,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final String day;
  final String date;
  final String checkInTime;
  final String checkOutTime;
  final String workTime;
  final String additionalTime;
  final String departureLocation;

  const AttendanceCard({
    super.key,
    required this.day,
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
    required this.workTime,
    required this.additionalTime,
    required this.departureLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$day $date",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AttendanceInfoRow(label: "وقت الحضور".tr(), value: checkInTime),
                AttendanceInfoRow(
                    label: "وقت الانصراف".tr(), value: checkOutTime),
                AttendanceInfoRow(label: "وقت العمل".tr(), value: workTime),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AttendanceInfoRow(
                    label: "وقت اضافي".tr(), value: additionalTime),
                AttendanceInfoRow(
                    label: "مكان الانصراف".tr(), value: departureLocation),
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}

class AttendanceInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const AttendanceInfoRow(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
         Divider(color: AppColors.black,thickness: 1),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
