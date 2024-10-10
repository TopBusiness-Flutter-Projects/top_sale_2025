import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/clients/screens/widgets/custom_card_client.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../details_order/screens/widgets/rounded_button.dart';
import '../../login/widget/textfield_with_text.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: GestureDetector(
        onTap: () {
          _showBottomSheet(context);
        },
        child: Container(
          height: 30.sp,
          width: 30.sp,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadiusDirectional.circular(90),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              size: 20.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        leadingWidth: 20,
        title: Text(
          'clients'.tr(),
          style: TextStyle(
            fontFamily: AppStrings.fontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return const CustomCardClient();
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(getSize(context)/20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                CustomTextFieldWithTitle(
                  title: "name".tr(),
                  controller: TextEditingController(),
                  hint: "enter_name".tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: getSize(context)/30,),
                CustomTextFieldWithTitle(
                  title: "phone".tr(),
                  controller: TextEditingController(),
                  hint: "enter_phone".tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: getSize(context)/30,),
                CustomTextFieldWithTitle(
                  title: "email".tr(),
                  controller: TextEditingController(),
                  hint: "enter_email".tr(),
                  keyboardType: TextInputType.text,
                ),  SizedBox(height: getSize(context)/30,),
                CustomTextFieldWithTitle(
                  title: "address".tr(),
                  controller: TextEditingController(),
                  hint: "enter_address".tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: getSize(context)/30,),
                Padding(
                  padding:  EdgeInsets.only(left: getSize(context)/20, right: getSize(context)/20),
                  child: RoundedButton(
                    backgroundColor: AppColors.primaryColor,
                    text: 'confirm'.tr(),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}