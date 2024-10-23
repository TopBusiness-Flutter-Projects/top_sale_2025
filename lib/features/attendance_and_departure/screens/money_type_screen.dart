import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/features/attendance_and_departure/cubit/attendance_and_departure_cubit.dart';
import 'package:top_sale/features/attendance_and_departure/cubit/attendance_and_departure_state.dart';
import 'package:top_sale/features/login/widget/textfield_with_text.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/get_size.dart';
import '../../details_order/screens/widgets/rounded_button.dart';

XFile? _image;

class MoneyTypeScreen extends StatefulWidget {
  const MoneyTypeScreen({super.key});

  @override
  State<MoneyTypeScreen> createState() => _MoneyTypeScreenState();
}

class _MoneyTypeScreenState extends State<MoneyTypeScreen> {
  final ImagePicker _picker = ImagePicker();
  List<String> titles = ["بنزين العربية", "صيانة العربية", ""];

  // Function to open the camera
  Future<void> _openCamera() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        title: Text(
          "money_types".tr(),
          style: getBoldStyle(fontSize: 20.sp),
        ),
      ),
      body: BlocBuilder<AttendanceAndDepartureCubit, AttendanceAndDepartureState>(
        builder: (context, state) {
          var cubit = context.read<AttendanceAndDepartureCubit>();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _showBottomSheet(_openCamera, context, cubit);
                },
                child: MoneyTypeRow(
                  image: ImageAssets.clients,
                  moneyType: titles[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MoneyTypeRow extends StatelessWidget {
  final String moneyType;
  final String image;

  const MoneyTypeRow({
    super.key,
    required this.moneyType,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 20.sp),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 20.sp,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(width: 20.sp),
          Text(
            moneyType,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

void _showBottomSheet(
    void Function() openCamera,
    BuildContext context,
    AttendanceAndDepartureCubit cubit,
    ) {
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
          bottom: MediaQuery.of(context).viewInsets.bottom + getSize(context) / 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [


                GestureDetector(
                  onTap: openCamera, // Use the passed camera function
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _image == null
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined, size: 40, color: AppColors.primary),
                          SizedBox(height: 5.sp),
                          const Text(
                            'ارفع الصورة',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        // Display the image using Image.file
                        File(_image!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),

                // Show success message
                if (_image != null)
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'تم رفع الصورة بنجاح',
                      style: TextStyle(color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ),

                CustomTextFieldWithTitle(
                  title: "paid".tr(),
                  controller: cubit.reasonController,
                  hint: "enter_paid".tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: getSize(context) / 30),
                CustomTextFieldWithTitle(
                  title: "payment_type".tr(),
                  controller: cubit.reasonController,
                  hint: "enter_payment".tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: getSize(context) / 30),
                Padding(
                  padding: EdgeInsets.only(left: getSize(context) / 20, right: getSize(context) / 20),
                  child: RoundedButton(
                    backgroundColor: AppColors.primaryColor,
                    text: 'add'.tr(),
                    onPressed: () {},
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
