import 'package:easy_localization/easy_localization.dart';
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
import 'widget/custom_button.dart';
import 'widget/textfield_with_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leadingWidth: 20,
            title: Text(
              'create_account'.tr(),
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
                CustomTextFielWithTitle(
                  controller: cubit.usernameController,
                  hint: 'username_invalid'.tr(),
                  keyboardType: TextInputType.name,
                  title: 'username'.tr(),
                ),
                CustomTextFielWithTitle(
                  keyboardType: TextInputType.visiblePassword,
                  controller: cubit.passwordController,
                  hint: 'password_invalid'.tr(),
                  title: 'password'.tr(),
                ),
                CustomTextFielWithTitle(
                  controller: cubit.emplyeeNumberController,
                  hint: 'emplyee_num_invalid'.tr(),
                  title: 'emplyee_num'.tr(),
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
