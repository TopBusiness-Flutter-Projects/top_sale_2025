import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../utils/assets_manager.dart';

class CustomDecodedImageWithText extends StatelessWidget {
  const CustomDecodedImageWithText(
      {super.key,
      required this.base64String,
      required this.context,
      this.height,
      this.character,
      this.width});
  final String? character;

  final dynamic base64String;
  final BuildContext context;
  final double? height;
  final double? width;
  Widget convertImage() {
    var image;
    if (base64String.runtimeType == String) {
      Uint8List bytes = base64.decode(base64String);
      image = Image.memory(
        Uint8List.fromList(bytes),
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
    } else {
      image = Center(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            ImageAssets.backgroundProduct,
            height: height,
            width: width,
          ),
          Text(character ?? '',
              style: getBoldStyle(color: AppColors.black, fontSize: 18.sp)),
        ],
      ));
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: convertImage());
  }
}
