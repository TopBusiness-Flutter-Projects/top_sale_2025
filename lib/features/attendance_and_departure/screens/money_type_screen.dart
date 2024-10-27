import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/features/attendance_and_departure/cubit/attendance_and_departure_cubit.dart';
import 'package:top_sale/features/attendance_and_departure/cubit/attendance_and_departure_state.dart';
import 'package:top_sale/features/login/widget/textfield_with_text.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/get_size.dart';
import '../../../core/widgets/decode_image.dart';
import '../../details_order/screens/widgets/rounded_button.dart';

class MoneyTypeScreen extends StatefulWidget {
  const MoneyTypeScreen({super.key});

  @override
  State<MoneyTypeScreen> createState() => _MoneyTypeScreenState();
}

class _MoneyTypeScreenState extends State<MoneyTypeScreen> {
  @override
  void initState() {
    context.read<AttendanceAndDepartureCubit>().getAllExpensesProduct();
    context.read<AttendanceAndDepartureCubit>().getAllJournals();
    super.initState();
  }

  List<String> titles = ["بنزين العربية", "صيانة العربية", ""];

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
      body:
          BlocBuilder<AttendanceAndDepartureCubit, AttendanceAndDepartureState>(
        builder: (context, state) {
          var cubit = context.read<AttendanceAndDepartureCubit>();
          return (cubit.getAllExpensesProductModel == null)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: cubit.getAllExpensesProductModel!.products!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _showBottomSheet(
                            context,
                            cubit,
                            cubit.getAllExpensesProductModel!.products![index]
                                    .id ??
                                1);
                      },
                      child: MoneyTypeRow(
                        image: "",
                        moneyType: cubit
                            .getAllExpensesProductModel!.products![index].name
                            .toString(),
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
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(100),
          //   child:Image.network(image)
          // ),
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
    BuildContext context, AttendanceAndDepartureCubit cubit, int productId) {
  cubit.descriptionController.clear();
  cubit.amountController.clear();
  cubit.profileImage = null;
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BlocBuilder<AttendanceAndDepartureCubit,
          AttendanceAndDepartureState>(builder: (context, state) {
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
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.showImageSourceDialog(context);
                        }, // Use the passed camera function
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: cubit.profileImage == null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud_upload_outlined,
                                          size: 40, color: AppColors.primary),
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
                                    File(cubit.profileImage!.path),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.removeImage();
                          },
                          icon: CircleAvatar(
                              backgroundColor: AppColors.secondPrimary,
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 30,
                              )))
                    ],
                  ),
                  CustomTextFieldWithTitle(
                    withPadding: false,
                    title: "describtion".tr(),
                    controller: cubit.descriptionController,
                    hint: "describtion".tr(),
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: getSize(context) / 30),
                  CustomTextFieldWithTitle(
                    withPadding: false,
                    title: "paid".tr(),
                    controller: cubit.amountController,
                    hint: "enter_paid".tr(),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: getSize(context) / 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: cubit
                            .selectedPaymentMethod, // This will store the ID (not the name)
                        hint: Text(
                          'choose_payment_method'.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.grey),
                        isExpanded: true,
                        onChanged: (int? newValue) {
                          cubit.changeJournal(
                              newValue!); // Store the ID in cubit
                        },
                        items: cubit.getAllJournalsModel?.result
                                ?.map<DropdownMenuItem<int>>((resultItem) {
                              return DropdownMenuItem<int>(
                                value: resultItem.id,
                                child: Text(resultItem.displayName ??
                                    ''), // Display the name
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                  ),
                  SizedBox(height: getSize(context) / 30),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getSize(context) / 20,
                        right: getSize(context) / 20),
                    child: RoundedButton(
                      backgroundColor: AppColors.primaryColor,
                      text: 'add'.tr(),
                      onPressed: () {
                        cubit.createExpense(context, productId: productId);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
