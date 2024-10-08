import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_strings.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/features/login/cubit/cubit.dart';
import 'package:top_sale/features/login/cubit/state.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/get_size.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              'تسجيل الدخول',
              style: TextStyle(
                  fontFamily: AppStrings.fontFamily,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(ImageAssets.logoImage,
                        width: getSize(context) / 2)),
                CustomTextFielWithTitle(
                  controller: cubit.usernameController,
                  hint: ' ادخل اسم المستخدم',
                  keyboardType: TextInputType.name,
                  title: 'اسم المستخدم',
                ),
                CustomTextFielWithTitle(
                  keyboardType: TextInputType.visiblePassword,
                  controller: cubit.passwordController,
                  hint: 'ادخل كلمة المرور',
                  title: 'كلمة المرور',
                ),
                CustomTextFielWithTitle(
                  controller: cubit.emplyeeNumberController,
                  hint: 'ادخل رقم الموظف',
                  title: 'رقم الموظف',
                  keyboardType: TextInputType.number,
                ),
                CustomButton(onTap: () {
                  Navigator.pushNamed(context, Routes.mainRoute);
                })
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.onTap});
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getSize(context) / 12, vertical: getSize(context) / 32),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(getSize(context) / 12),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(getSize(context) / 32),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(getSize(context) / 12),
          ),
          child: Text(
            'تسجيل الدخول',
            style: TextStyle(
              color: AppColors.white,
              fontFamily: AppStrings.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFielWithTitle extends StatelessWidget {
  CustomTextFielWithTitle({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.keyboardType,
  });
  TextInputType? keyboardType;
  TextEditingController controller;
  String title;
  String hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(getSize(context) / 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                color: AppColors.black,
                fontWeight: FontWeight.w500),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return hint;
              } else {
                return null;
              }
            },
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsetsDirectional.only(start: 8),
              hintText: hint,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greyColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(getSize(context) / 32),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greyColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(getSize(context) / 32),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greyColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(getSize(context) / 32),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greyColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(getSize(context) / 32),
              ),
            ),
          )
        ],
      ),
    );
  }
}
