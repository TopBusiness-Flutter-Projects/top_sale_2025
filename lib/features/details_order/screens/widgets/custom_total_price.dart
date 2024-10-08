import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_fonts.dart';

class CustomTotalPrice extends StatelessWidget {
   CustomTotalPrice({super.key,required price});
String ?price;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        width: screenWidth * 0.9, // Make the container responsive
        //   height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              // blurRadius: 10,
              // spreadRadius: 2,
              //  offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Shipment Number
            Text(
              "total".tr(),
              style: getBoldStyle(),
            ),
            Text(
              "\$40",
              style: getBoldStyle(),
            ),
          ],
        ));
  }
}
