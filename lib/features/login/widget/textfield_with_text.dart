import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/get_size.dart';

class CustomTextFielWithTitle extends StatefulWidget {
  CustomTextFielWithTitle({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final TextInputType? keyboardType;

  @override
  _CustomTextFielWithTitleState createState() =>
      _CustomTextFielWithTitleState();
}

class _CustomTextFielWithTitleState extends State<CustomTextFielWithTitle> {
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
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscureText: widget.keyboardType == TextInputType.visiblePassword &&
                !_isPasswordVisible,
            decoration: InputDecoration(
              contentPadding: const EdgeInsetsDirectional.only(start: 8),
              hintText: widget.hint,
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
