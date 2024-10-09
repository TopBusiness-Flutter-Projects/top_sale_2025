import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_strings.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/features/login/cubit/cubit.dart';
import 'package:top_sale/features/login/cubit/state.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/get_size.dart';
import '../widget/custom_button.dart';
import '../widget/textfield_with_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      var cubit = context.read<LoginCubit>();
      return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              'login'.tr(),
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
                    child: Image.asset(
                  ImageAssets.logoImage,
                  width: getSize(context) / 1.4,
                  // height: getSize(context) / 1.4,
                )),
                SizedBox(
                  height: getSize(context) / 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            cubit.onchangeEmplyeeStatus(false);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  'user'.tr(),
                                  style: TextStyle(
                                    color: cubit.isEmplyee
                                        ? AppColors.black
                                        : AppColors.yellowColor,
                                    fontWeight: FontWeight.w700,

                                    fontFamily: 'cairo',
                                    fontSize: getSize(context) / 22,
                                    // decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.solid,
                                  ),
                                ),
                              ),
                              cubit.isEmplyee
                                  ? const SizedBox(
                                      height: 2,
                                    )
                                  : IntrinsicHeight(
                                      child: Container(
                                          height: 2,
                                          color: AppColors.yellowColor),
                                    )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getSize(context) / 32,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            cubit.onchangeEmplyeeStatus(true);
                          },
                          child: Column(
                            children: [
                              Text(
                                'emplyee'.tr(),
                                style: TextStyle(
                                  color: cubit.isEmplyee
                                      ? AppColors.yellowColor
                                      : AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'cairo',
                                  fontSize: getSize(context) / 22,
                                  // decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                              cubit.isEmplyee
                                  ? IntrinsicHeight(
                                      child: Container(
                                          // width: 70,
                                          height: 2,
                                          color: AppColors.yellowColor),
                                    )
                                  : const SizedBox(
                                      height: 2,
                                    )
                            ],
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                cubit.isEmplyee
                    ? CustomTextFieldWithTitle(
                        controller: cubit.emplyeeNumberController,
                        hint: 'emplyee_num_invalid'.tr(),
                        title: 'emplyee_num'.tr(),
                        keyboardType: TextInputType.number)
                    : CustomTextFieldWithTitle(
                        controller: cubit.usernameController,
                        hint: 'username_invalid'.tr(),
                        keyboardType: TextInputType.name,
                        title: 'username'.tr(),
                      ),
                CustomTextFieldWithTitle(
                    keyboardType: TextInputType.visiblePassword,
                    controller: cubit.passwordController,
                    hint: 'password_invalid'.tr(),
                    title: 'password'.tr()),
                CustomButton(
                    title: 'login'.tr(),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.mainRoute);
                    }),
                Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.registerScreen);
                              },
                              child: Text('new_account'.tr())),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.registerScreen);
                              },
                              child: Text('try_the_app'.tr(),
                                  style: TextStyle(
                                      color: AppColors.orangeThirdPrimary)))
                        ]))
              ])));
    });
  }
}
