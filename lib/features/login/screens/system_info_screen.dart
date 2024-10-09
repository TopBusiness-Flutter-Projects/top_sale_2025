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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      var cubit = context.read<LoginCubit>();
      return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              'new_account'.tr(),
              style: TextStyle(
                  fontFamily: AppStrings.fontFamily,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          body: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                  child: Image.asset(
                ImageAssets.logoImage,
                width: getSize(context) / 1.4,
                // height: getSize(context) / 1.4,
              )),
              SizedBox(
                height: getSize(context) / 8,
              ),
              CustomTextFieldWithTitle(
                controller: cubit.companynameController,
                hint: 'companyname_invalid'.tr(),
                keyboardType: TextInputType.name,
                title: 'companyname'.tr(),
              ),
              CustomTextFieldWithTitle(
                  keyboardType: TextInputType.url,
                  controller: cubit.odooLinkController,
                  hint: 'odoo_link_invalid'.tr(),
                  title: 'odoo_link'.tr()),
              CustomTextFieldWithTitle(
                  controller: cubit.dbNumberController,
                  hint: 'db_name_invalid'.tr(),
                  title: 'db_name'.tr(),
                  keyboardType: TextInputType.text),
              CustomButton(
                  title: 'register'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.loginRoute);
                  }),
            ]),
          )));
    });
  }
}
