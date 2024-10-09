import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/get_size.dart';

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
      padding: EdgeInsets.symmetric(
        horizontal: getSize(context) / 32,
        vertical: getSize(context) / 44,
      ),
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
          const SizedBox(height: 5),
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
