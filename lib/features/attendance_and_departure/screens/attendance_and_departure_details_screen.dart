import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import '../../../core/models/get_all_attendance_model.dart';
import '../cubit/attendance_and_departure_cubit.dart';
import '../cubit/attendance_and_departure_state.dart';

class AttendanceAndDepartureDetailsScreen extends StatefulWidget {
  const AttendanceAndDepartureDetailsScreen({super.key});

  @override
  State<AttendanceAndDepartureDetailsScreen> createState() =>
      _AttendanceAndDepartureDetailsScreenState();
}

class _AttendanceAndDepartureDetailsScreenState
    extends State<AttendanceAndDepartureDetailsScreen> {
  @override
  initState() {
    context.read<AttendanceAndDepartureCubit>().getAllAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AttendanceAndDepartureCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(

        titleTextStyle: getBoldStyle(fontSize: 20.sp),
        title: Text('attendance_and_departure_details'.tr()),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: BlocBuilder<AttendanceAndDepartureCubit,
            AttendanceAndDepartureState>(builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date pickers
              // Row(
              //   children: [
              //     Expanded(
              //         child: DatePickerField(
              //             label: 'from'.tr(),
              //             selectedDate: cubit.fromDate.toString())),
              //     SizedBox(width: 20.w),
              //     Expanded(
              //       child: DatePickerField(
              //           label: 'to'.tr(),
              //           selectedDate: cubit.toDate.toString()),
              //     )
              //   ],
              // ),
              SizedBox(height: 20.h),
              cubit.getAllAttendanceModel.attendances == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: cubit.getAllAttendanceModel.attendances == null ||
                              cubit.getAllAttendanceModel.attendances!
                                  .isEmpty ||
                              cubit.getAllAttendanceModel.attendances == []
                          ? Text("no_data".tr())
                          : RefreshIndicator(
                        onRefresh: () async {
                          cubit.getAllAttendance();
                        },
                        child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => AttendanceCard(
                                  attendance: cubit
                                      .getAllAttendanceModel.attendances![index],
                                ),
                                itemCount: cubit
                                    .getAllAttendanceModel.attendances!.length,
                              ),
                          ),
                    ),
            ],
          );
        }),
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
  Attendance attendance;

  AttendanceCard({super.key, required this.attendance});

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
              attendance.checkIn.toString().substring(0,10) ?? "",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AttendanceInfoRow(
                  label: "attendance_time".tr(),
                  value: attendance.checkIn == null
                      ? ""
                      : attendance.checkIn!.toString().substring(11, 16),
                ),
                AttendanceInfoRow(
                  label: "dismissal_time".tr(),
                  value: attendance.checkOut == null
                      ? ""
                      : attendance.checkOut!.toString().substring(11, 16),
                ),
                AttendanceInfoRow(
                  label: "work_time".tr(),
                  value: attendance.workedHours.toInt().toString(),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AttendanceInfoRow(
                  label: "additional_time".tr(),
                  value: attendance.employeeId == null
                      ? ""
                      : attendance.employeeId.toString(),
                ),
                AttendanceInfoRow(
                  label: "attendance_place".tr(),
                  value: (attendance.outCity == false) ?
                  "":attendance.outCity ?? '',
                ),
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
        Divider(color: AppColors.black, thickness: 1),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
