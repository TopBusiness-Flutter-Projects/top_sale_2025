import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/models/get_orders_model.dart';
import '../../../../core/models/order_details_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/get_size.dart';
import '../../../../core/widgets/decode_image.dart';

class CardDetailsOrders extends StatelessWidget {
  CardDetailsOrders(
      {super.key,required this.orderDetailsModel,required this.orderModel});
  OrderDetailsModel orderDetailsModel;
  OrderModel  orderModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    
      child: Container(
        width: getSize(context),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.1), // لون الظل مع تقليل الشفافية
              spreadRadius: 1, // مدى انتشار الظل
              blurRadius: 1, // مدى نعومة الظل
              offset: const Offset(0, 1), // الاتجاه الأفقي والرأسي للظل
            ),
          ],
          color: AppColors.white,
          borderRadius: BorderRadius.circular(getSize(context) / 30),
        ),
        child: Padding(
          padding: EdgeInsets.all(getSize(context) / 25),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      AutoSizeText(
                        "shipment_number".tr(),
                        style: TextStyle(
                          fontFamily: "cairo",
                          color: AppColors.blue,
                          fontSize: getSize(context) / 25,
                        ),
                      ),
                      SizedBox(width: getSize(context) / 60),
                      Expanded(
                        child: AutoSizeText(
                          orderDetailsModel.name ?? '',
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "cairo",
                            color: AppColors.black,
                            fontSize: getSize(context) / 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                
              ],
            ),
            SizedBox(
              height: getSize(context) / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset(
                        ImageAssets.dateIcon,
                        fit: BoxFit.contain,
                        width: getSize(context) / 14,
                        height: getSize(context) / 14,
                      ),
                      SizedBox(width: getSize(context) / 60),
                      AutoSizeText(
                        orderDetailsModel.dateOrder.substring(0, 10) ?? '',                         style: TextStyle(
                          fontFamily: "cairo",
                          color: AppColors.black,
                          fontSize: getSize(context) / 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "total".tr(),
                        style: TextStyle(
                          fontFamily: "cairo",
                          color: AppColors.blue,
                          fontSize: getSize(context) / 25,
                        ),
                      ),
                      SizedBox(width: getSize(context) / 60),
                      AutoSizeText(
                        "${orderDetailsModel.amountTotal} \$",
                        style: TextStyle(
                          fontFamily: "cairo",
                          color: AppColors.black,
                          fontSize: getSize(context) / 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getSize(context) / 20,
            ),
            Row(
              children: [
                // orderModel.partnerModel?.image1920.toString()=='false'?
                //
                //     Center(
                //       child: Image.asset(ImageAssets.user),
                //     )
                //     :   CustomDecodedImage(
                //   context: context,
                //   base64String: orderModel.partnerModel!.image1920,
                //   height: 50.w,
                //   width: 50.w,
                // )             ,   // Image.asset(ImageAssets.user),
                Center(child: Image.asset(ImageAssets.user)),
                SizedBox(width: getSize(context) / 60),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        orderModel.partnerModel!.name ?? '',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: getSize(context) / 25,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        (orderModel.partnerModel?.phone.toString() == "false")
                            ? '000000001/100000000'
                            : orderModel.partnerModel?.phone ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "cairo",
                          color: AppColors.black.withOpacity(0.8),
                          fontSize: getSize(context) / 28,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
