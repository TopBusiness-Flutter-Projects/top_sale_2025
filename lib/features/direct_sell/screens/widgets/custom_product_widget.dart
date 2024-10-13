import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/core/utils/get_size.dart';

import '../../../../core/widgets/decode_image.dart';

class CustomProductWidget extends StatelessWidget {
  const CustomProductWidget({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    required this.numofadded,
  });
  final String title;
  final String price;
  final String numofadded;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            // height: getheightSize(context) / 12,
            // width: getheightSize(context) / 12,
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: getSize(context) / 3,
                    decoration: BoxDecoration(
                        color: AppColors.orangeThirdPrimary,
                        borderRadius: BorderRadius.circular(18.r)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: image == "false"
                          ? Center(
                              child: Text(
                                  title.substring(0, title.indexOf(" ")),
                                  style: getBoldStyle(
                                      color: AppColors.white, fontSize: 18.sp)),
                            )
                          :
                      CustomDecodedImage(
                        context: context,
                        base64String: image,
                        height: 50.w,
                        width: 50.w,
                      )
                      // Image.network(
                      //         image,
                      //         fit: BoxFit.cover,
                      //       ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(title + "\n",
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(color: AppColors.primaryGrey)),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(price + " " + "currency".tr(),
                          // maxLines: 2,
                          // textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                              color: AppColors.orangeThirdPrimary)),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(
                          color: AppColors.orangeThirdPrimary, width: 1.8),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.pop(context);
                              // context.read<>
                            },
                            child: Icon(
                              Icons.add,
                              color: AppColors.orangeThirdPrimary,
                              size: 30.w,
                            ),
                          ),
                          //SizedBox(width: 8.w),
                          Text(numofadded,
                              style: getBoldStyle(
                                  color: AppColors.primary, fontHeight: 1.3)),
//SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.remove,
                              color: AppColors.orangeThirdPrimary,
                              size: 30.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
