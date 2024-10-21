import 'package:auto_size_text/auto_size_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:top_sale/core/utils/get_size.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/models/get_orders_model.dart';
import '../../../../core/widgets/decode_image_with_text.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {super.key,
      required this.text,
      required this.number,
      required this.price,
      required this.title,
      required this.order});
  String text;
  String number;
  String price;
  String title;
  OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Product price
            Flexible(
              fit: FlexFit.tight,
              child: Row(
                children: [
                  // Product details
                  CustomDecodedImageWithText(
                    character: title.length >= 2
                        ? title.removeAllWhitespace.substring(0, 2).toString()
                        : title.removeAllWhitespace,
                    base64String: false,
                    context: context,
                    width: getSize(context) / 6,
                    height: getSize(context) / 6,
                  ),

                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: getSize(context) / 1.8,
                          child: AutoSizeText(
                            text,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getSize(context) / 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: getSize(context) / 50),
                        Text('عدد : $number',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.orange,
                              fontSize: getSize(context) / 28,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$price ${order.currencyId?.name ?? ''} ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: getSize(context) / 28,
              ),
              //  textDirection: TextDirection!.RTL,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: getSize(context) / 50),
          child: Divider(thickness: 1, color: AppColors.gray.withOpacity(0.5)),
        ),
      ],
    );
  }
}
