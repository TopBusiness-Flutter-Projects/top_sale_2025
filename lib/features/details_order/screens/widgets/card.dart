import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/assets_manager.dart';

class CustomDetailsCard extends StatelessWidget {
  const CustomDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // For responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;

    return  Container(

      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      width: screenWidth * 0.9, // Make the container responsive
     // height: 100.h,
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 6,

           // spreadRadius: .5,
            //offset: const Offset(1, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Shipment Number
            Flexible(child: Text("shipment_number".tr()+": ", style: getBoldStyle(color: AppColors.secondPrimary,fontweight: FontWeight.w700))),
              Flexible(
                child: Text(
                   '00000456',
                  maxLines: 1,
                    style: getBoldStyle(fontweight: FontWeight.w700)
                ),
              ),

              // Date Icon with Date

            ],
          ),

          const SizedBox(height: 16), // Spacing between rows

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Shipment Number
              Row(
                children:  [
                  Image.asset(ImageAssets.timeTableIcon),
                  // Icon(Icons.calendar_today_outlined, size: 16, color: Colors.blue),
                  SizedBox(width: 10.w),
                  Text(
                    '10/7/2024',
                    style:getBoldStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              Row(children: [
                Text("total".tr()+":",style:getBoldStyle(color: AppColors.secondPrimary,fontweight:  FontWeight.w700) ,),
                Text("\$40",style:getBoldStyle(color: AppColors.primary,fontweight:  FontWeight.w700) ,),
              ],)
              // Date Icon with Date

            ],
          ),


          SizedBox(height: 16.h), // Spacing between rows

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8.w,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      'customer_name'.tr(),
                   style:   getBoldStyle(fontSize: 14.sp,fontweight: FontWeight.w700)
                    ),
                    SizedBox(height: 5),
                    Text(
                      '01000000000 / 01000jkdnkjnjnjnjnjnjnjnjj000000',
                      style:getRegularStyle(),
                      maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Avatar or Client Icon

            ],
          ),
        ],
      ),
    );
  }
}
