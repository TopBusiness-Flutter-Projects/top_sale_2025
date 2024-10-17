import 'package:auto_size_text/auto_size_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/get_size.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/models/get_orders_model.dart';

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
            Row(
              children: [
                // Product details
                CircleAvatar(
                    backgroundColor: AppColors.orange,
                    child: Center(
                      child: Text(
                          title.length > 5 ? title.substring(0, 3) : title,
                          style: getBoldStyle(
                              color: AppColors.white, fontSize: 18.sp)),
                    )),
                SizedBox(width: getSize(context) / 50),
                Column(
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
              ],
            ),
            Text(
              '$price ${order.currencyId?.name ?? '\$'} ',
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
