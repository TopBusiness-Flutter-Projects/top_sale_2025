import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/update_profile/cubit/update_profile_cubit.dart';
import 'package:top_sale/features/update_profile/cubit/update_profile_state.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/assets_manager.dart';
import '../../login/widget/custom_button.dart';
import '../../login/widget/textfield_with_text.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UpdateProfileCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
            builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: getSize(context) / 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.sp,
                        backgroundImage: const AssetImage(ImageAssets.user),
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.camera_alt,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getSize(context) / 30,
              ),
              CustomTextFieldWithTitle(
                hint: "ثناء عادل",
                controller: cubit.nameController,
                title: "name".tr(),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: getSize(context) / 30,
              ),
              CustomTextFieldWithTitle(
                hint: "000000000000",
                controller: cubit.phoneController,
                title: "phone".tr(),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: getSize(context) / 30,
              ),
              CustomTextFieldWithTitle(
                hint: "sanaa@gmail.com",
                controller: cubit.emailController,
                title: "email".tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: getSize(context) / 8,
              ),
              CustomButton(
                title: "modify".tr(),
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
        // //leadingWidth: 20,
        title: Text(
          "update_profile".tr(),
          style: getBoldStyle(
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}