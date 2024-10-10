import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:top_sale/features/contact_us/cubit/contact_us_state.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/assets_manager.dart';
import '../../login/widget/custom_button.dart';
import '../../login/widget/textfield_with_text.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ContactUsCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,

      body: SingleChildScrollView(
        child: BlocBuilder<ContactUsCubit, ContactUsState>(
            builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: getSize(context) / 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageAssets.contactUs),
                  SizedBox(height: getSize(context) / 10),
                ],
              ),
              Column(
                children: [
                  CustomTextFieldWithTitle(
                    hint: "ثناء عادل",
                    controller: cubit.nameController,
                    title: "name".tr(),
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: getSize(context) / 30),
                  CustomTextFieldWithTitle(
                    hint: "enter_subject".tr(),
                    controller: cubit.subjectController,
                    title: "subject".tr(),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: getSize(context) / 30),
                  CustomTextFieldWithTitle(
                    // maxLines: 5,
                    hint: "write_your_message".tr(),
                    controller: cubit.messageController,
                    title: "message".tr(),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
              SizedBox(height: getSize(context) / 30),
              CustomButton(
                title: "send".tr(),
                onTap: () {},
              )
            ],
          );
        }),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_outlined,
            size: 25.w,
          ),
        ),
        // leadingWidth: 20,
        title: Text(
          "leave_your_message".tr(),
          style: getBoldStyle(
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
