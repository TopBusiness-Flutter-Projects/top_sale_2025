import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/get_size.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/assets_manager.dart';

class ProductCard extends StatelessWidget {
   const ProductCard({super.key,required this.text, required this.number, required this.price, required this.title});
   final String text;
   final String number;
   final String price;
   final String title;
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
                  child:
                  Center(
                    child: Text(
                        title.length > 5 ? title.substring(0, 3) : title,
                        style: getBoldStyle(
                            color: AppColors.white, fontSize: 18.sp)),
                  )
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
