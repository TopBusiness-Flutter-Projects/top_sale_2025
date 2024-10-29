import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assets_manager.dart';

class CustomDecodedImage extends StatelessWidget {
  const CustomDecodedImage({
    super.key,
    required this.base64String,
    this.height,
    this.width,
  });

  final dynamic base64String;
  final double? height;
  final double? width;

  bool isSvgData(String data) {
    try {
      final decodedString = utf8.decode(base64.decode(data));
      return decodedString.contains("<svg");
    } catch (e) {
      print('Failed to detect SVG data: $e');
      return false;
    }
  }

  Widget buildImageWidget() {
    if (base64String is String) {
      try {
        if (isSvgData(base64String)) {
          return SvgPicture.string(
            utf8.decode(base64.decode(base64String)),
            height: height,
            width: width,
            fit: BoxFit.cover,
          );
        } else {
          Uint8List bytes = base64.decode(base64String);
          return Image.memory(
            bytes,
            height: height,
            width: width,
            fit: BoxFit.cover,
          );
        }
      } catch (e) {
        print('Error decoding image: $e');
      }
    }
    // Fallback to asset image on error
    return Image.asset(
      ImageAssets.logo2Image,
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: buildImageWidget());
  }
}
