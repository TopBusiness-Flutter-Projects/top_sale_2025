import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/assets_manager.dart';

class ProductCard extends StatelessWidget {
   ProductCard({super.key,required this.text});
String? text;
  @override
  Widget build(BuildContext context) {
    // For responsiveness
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

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
                  borderRadius: BorderRadius.circular(8.0),
                  child:
                  Image.asset(ImageAssets.logoImage,scale:20
                    // Image  .network(
                    //   'https://images.unsplash.com/photo-1611078489446-9aa582f8145e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                    //  width: 50,
                    //   height: 50,
                    //   fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                     text!, // Product name
                      style: getBoldStyle(fontweight: FontWeight.w700)
                      // TextStyle(
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 16,
                      //   color: Colors.black,
                      // ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'عدد : 2', // Quantity
                      style:
                     getRegularStyle(color:AppColors.orange)
                    ),
                  ],
                ),


              ],
            ),
             Text(
              '\$40',
              style:
              getBoldStyle(color:AppColors.orange),
              // TextStyle(
              //   fontWeight: FontWeight.bold,
              //   color: Colors.orange,
              //   fontSize: 18,
              // ),
              textDirection: TextDirection.rtl,
            ),

            // Product name, quantity, and image

          ],
        ),

        // Divider line
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(thickness: 1, color: Colors.grey),
        ),
      ],
    );
  }
}
