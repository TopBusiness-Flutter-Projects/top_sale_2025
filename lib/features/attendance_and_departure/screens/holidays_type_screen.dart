import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/features/attendance_and_departure/cubit/attendance_and_departure_cubit.dart';
import 'package:top_sale/features/attendance_and_departure/cubit/attendance_and_departure_state.dart';
import 'package:top_sale/features/login/widget/textfield_with_text.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/get_size.dart';
import '../../details_order/screens/widgets/rounded_button.dart';

class HolidaysTypeScreen extends StatelessWidget {
  const HolidaysTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        title: Text(
          "holidays_types".tr(),
          style: getBoldStyle(fontSize: 20.sp),
        ),
      ),
      body: BlocBuilder<AttendanceAndDepartureCubit,AttendanceAndDepartureState>(
        builder: (context,state) {
          var cubit = context.read<AttendanceAndDepartureCubit>();
          return ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _showBottomSheet(context, cubit);
              },
              child: const LeaveRow(
                normalDays: "10",
                negativeDays: "5",
                leaveType: " اجازة مرضية ",
              ),
            );
          });
        }
      )
    );
  }
}

class LeaveRow extends StatelessWidget {
  final String normalDays;
  final String negativeDays;
  final String leaveType;

  const LeaveRow({
    super.key,
    required this.normalDays,
    required this.negativeDays,
    required this.leaveType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Leave Type on the right side
          Text(
            leaveType,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Days with negative number first (with strikethrough)
          RichText(
            text: TextSpan(
              children: [

                TextSpan(
                  text: "  $normalDays  ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Negative days in red with strikethrough
                if (negativeDays.isNotEmpty)
                  TextSpan(
                    text: "  $negativeDays ",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      decorationColor: AppColors.red,
                      decoration: TextDecoration.lineThrough, // Strikethrough effect
                    ),
                  ),
                // Normal days in black
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, AttendanceAndDepartureCubit cubit) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {

          return Padding(
            padding: EdgeInsets.only(
              left: getSize(context) / 20,
              right: getSize(context) / 20,
              top: getSize(context) / 20,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  getSize(context) / 20,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Expanded(child: DatePickerField(label: 'من', selectedDate: '23/2/2024')),
                        SizedBox(width: 20),
                        Expanded(child: DatePickerField(label: 'إلى', selectedDate: '23/2/2024'),
                        )
                      ],
                    ),
                    CustomTextFieldWithTitle(
                      maxLines: 5,
                      title: "reason".tr(),
                      controller: cubit.reasonController,
                      hint: "reason".tr(),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: getSize(context) / 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getSize(context) / 20,
                          right: getSize(context) / 20),
                      child: RoundedButton(
                        backgroundColor: AppColors.primaryColor,
                        text: 'add'.tr(),
                        onPressed: () {

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

  );
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