import 'package:flutter/material.dart';
import 'package:top_sale/core/utils/get_size.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';

class ProductCard extends StatelessWidget {
   const ProductCard({super.key,required this.text, required this.number, required this.price});
   final String text;
   final String number;
   final String price;
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(getSize(context)/12),
                  child:
                  Image.asset(
                      ImageAssets.logoImage,
                      scale:getSize(context)/20

                  ),
                ),
                 SizedBox(width: getSize(context)/50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                     text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getSize(context) / 25,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: getSize(context)/50),
                    Text(
                      'عدد : $number',
                      style:
                     TextStyle(  fontWeight: FontWeight.bold,
                       color: AppColors.orange,
                       fontSize: getSize(context) / 28,)
                    ),
                  ],
                ),


              ],
            ),
             Text(
              '40 \$',
              style:
              TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: getSize(context)/28,
              ),
              textDirection: TextDirection.rtl,
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
