import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/get_size.dart';
import '../../../core/utils/style_text.dart';

class CustomTextFieldWithTitle extends StatefulWidget {
  const CustomTextFieldWithTitle({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.keyboardType,
    this.readonly,
    this.isModify,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final bool ?readonly;
  final bool ?isModify;
  final TextInputType? keyboardType;

  @override
  _CustomTextFieldWithTitleState createState() =>
      _CustomTextFieldWithTitleState();
}

class _CustomTextFieldWithTitleState extends State<CustomTextFieldWithTitle> {
  bool _isPasswordVisible = false;

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
            widget.title,
            style: TextStyle(
              fontFamily: AppStrings.fontFamily,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return widget.hint;
              } else {
                return null;
              }
            },
            readOnly: widget.readonly??false,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscureText: widget.keyboardType == TextInputType.visiblePassword &&
                !_isPasswordVisible,
            decoration: InputDecoration(
              fillColor:widget.isModify == true?AppColors.gray.withOpacity(0.25):AppColors.white,
              contentPadding: const EdgeInsetsDirectional.only(start: 8),
              hintText: widget.hint,
              filled: true,
              hintStyle: widget.isModify == true?TextStyles.size16FontWidget400Gray.copyWith(color:  AppColors.greyColor):TextStyles.size16FontWidget400Gray,
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
              // Add a visibility toggle icon for password fields
              suffixIcon: widget.keyboardType == TextInputType.visiblePassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off,
                        color: AppColors.greyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
