import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/clients/screens/widgets/custom_card_client.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../details_order/screens/widgets/rounded_button.dart';
import '../../login/widget/textfield_with_text.dart';
import '../cubit/clients_cubit.dart';

class ClientScreen extends StatelessWidget {

  ClientScreen({this.isCart = false, super.key});
  bool isCart;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ClientsCubit>();
    return Scaffold(
        backgroundColor: AppColors.white,
        floatingActionButton: GestureDetector(
          onTap: () {
            _showBottomSheet(context,cubit);
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

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              CustomTextField(
                controller: cubit.searchController,
                onChanged: (keyValue) {
                  if (keyValue.isEmpty) {
                    // cubit.getAllProducts();
                  } else {
                    // EasyDebounce.debounce(
                    //     'search', // <-- An ID for this particular debouncer
                    //     Duration(
                    //         seconds: 1), // <-- The debounce duration
                    //     () => cubit.searchProducts(
                    //           productName: keyValue,
                    //         ) // <-- The target method
                    //     );
                  }
                },
                labelText: "search_product".tr(),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 35,
                  color: AppColors.gray2,
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.basketScreenRoute);
                        },
                        child: const CustomCardClient());
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void _showBottomSheet(BuildContext context,ClientsCubit cubit) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(getSize(context) / 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFieldWithTitle(

                  title: "name".tr(),
                  controller: cubit.clientNameController,
                  hint: "enter_name".tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: getSize(context) / 30,
                ),
                CustomTextFieldWithTitle(
                  title: "phone".tr(),
                  controller: cubit.phoneController,
                  hint: "enter_phone".tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: getSize(context) / 30,
                ),
                CustomTextFieldWithTitle(
                  title: "email".tr(),
                  controller: cubit.emailController,
                  hint: "enter_email".tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: getSize(context) / 30,
                ),
                CustomTextFieldWithTitle(
                  title: "address".tr(),
                  controller: cubit.addressController,
                  hint: "enter_address".tr(),
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
