import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import '../utils/assets_manager.dart';

class CustomDecodedImage extends StatelessWidget {
  const CustomDecodedImage(
      {super.key,
      required this.base64String,
      required this.context,
      this.height,
      this.width});

  final dynamic base64String;
  final BuildContext context;
  final double? height;
  final double? width;
  Widget convertImage() {
    Image image;
    if (base64String.runtimeType == String) {
      Uint8List bytes = base64.decode(base64String);
      image = Image.memory(
        Uint8List.fromList(bytes),
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
    } else {
      image = Image.asset(ImageAssets.logo2Image,
          height: height, width: width, fit: BoxFit.cover);
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: convertImage());
  }
}
