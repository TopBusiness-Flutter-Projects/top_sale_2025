import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/models/partner_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/get_size.dart';


class CustomSlalesCard extends StatelessWidget {
  CustomSlalesCard({super.key, required this.salesOrder});
  SalesOrder?salesOrder;
  @override
  Widget build(BuildContext context) {
    // print('image ::${salesOrder?.partnerId.!.image1920}::imageeeeeeeeeeee');
    return GestureDetector(
      onTap: () {
     //   print("salesOrder?.state ::${salesOrder?.state}::stateeeeeeeeeeee");
        // salesOrder?.state == 'draft'
        //     ? Navigator.pushNamed(context, Routes.detailsOrderShowPrice,
        //     arguments: salesOrder?)
        //     : Navigator.pushNamed(context, Routes.detailsOrder,
        //     arguments: salesOrder?);
      },
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
                        "shipment_number".tr()+' ${":"}',
                        style: TextStyle(
                          fontFamily: "cairo",
                          color: AppColors.secondPrimary,
                          fontSize:16.sp,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(width: getSize(context) / 60),
                      Expanded(
                        child: AutoSizeText(
                          salesOrder?.name.toString() ?? '',
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "cairo",
                            color: AppColors.primary,
                            fontSize: 16.sp,
                              fontWeight: FontWeight.w400

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: getSize(context) / 15,
                    width: getSize(context) / 5,
                    decoration: BoxDecoration(
                        color:
                        salesOrder?.state == "sale" &&
                            salesOrder?.invoiceStatus == "to invoice" &&
                            salesOrder?.delivery_status == "full"
                            ? AppColors.blue.withOpacity(0.5)
                            : salesOrder?.state == "sale" &&
                            salesOrder?.invoiceStatus == "invoiced" &&
                            salesOrder?.delivery_status == "full"
                            ? AppColors.green.withOpacity(0.5)
                            : salesOrder?.state == "sale" &&
                            salesOrder?.invoiceStatus == "to invoice" &&
                            salesOrder?.delivery_status == "pending"
                            ?
                        AppColors.orange.withOpacity(0.5)
                         : AppColors.orange.withOpacity(0.5),
                        borderRadius:
                        BorderRadius.circular(getSize(context) / 20)),
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(getSize(context) / 100),
                            child: AutoSizeText(
                             maxLines: 1,
                              salesOrder?.state == "sale" &&
                                  salesOrder?.invoiceStatus == "to invoice" &&
                                  salesOrder?.delivery_status == "full"
                                  ? "delivered".tr()
                                  : salesOrder?.state.toString() == "sale" &&
                                  salesOrder?.invoiceStatus == "invoiced" &&
                                  salesOrder?.delivery_status == "full"
                                  ? "complete".tr()
                                  : salesOrder?.state == "sale" &&
                                  salesOrder?.invoiceStatus ==
                                      "to invoice" &&
                                  salesOrder?.delivery_status == "pending"
                                  ? "new".tr()
                                  : salesOrder?.state == "draft"?
                               "show_price".tr()
                                  : '',
                              style: TextStyle(
                                color:
                                salesOrder?.state == "sale" &&
                                    salesOrder?.invoiceStatus == "to invoice" &&
                                    salesOrder?.delivery_status == "full"
                                    ? AppColors.blue
                                    : salesOrder?.state == "sale" &&
                                    salesOrder?.invoiceStatus == "invoiced" &&
                                    salesOrder?.delivery_status == "full"
                                    ? AppColors.green
                                    : salesOrder?.state == "sale" &&
                                    salesOrder?.invoiceStatus ==
                                        "to invoice" &&
                                    salesOrder?.delivery_status ==
                                        "pending"
                                    ?
    AppColors.orange
                                   : AppColors.orange,
                              ),
                            ))))
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
                        salesOrder?.dateOrder!.substring(0, 10) ?? '',
                        style: TextStyle(
                          fontFamily: "cairo",
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
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
                        "total".tr()+'${" :"}',
                        style: TextStyle(
                          fontFamily: "cairo",
                          color: AppColors.secondPrimary,
                          fontWeight: FontWeight.w700,

                          fontSize: getSize(context) / 25,
                        ),
                      ),
                      SizedBox(width: getSize(context) / 60),
                      AutoSizeText(
                        "${salesOrder?.amountTotal}",
                        style: TextStyle(
                          fontFamily: "cairo",
                          color: AppColors.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
   //          SizedBox(
   //            height: getSize(context) / 20,
   //          ),
   //          Row(
   //            children: [
   //              Center(
   //                  child: Image.asset(
   //                    ImageAssets.user,
   //                    width: getSize(context) / 12,
   //                    height: getSize(context) / 12,
   //                  )),
   //              SizedBox(width: getSize(context) / 60),
   //              Expanded(
   //                child: Column(
   //                  crossAxisAlignment: CrossAxisAlignment.start,
   //                  mainAxisAlignment: MainAxisAlignment.start,
   //                  children: [
   //                    AutoSizeText(
   //                      'اسم العميل',
   //                      maxLines: 1,
   //                      style: TextStyle(
   //                          fontSize: getSize(context) / 25,
   //                          color: AppColors.black,
   //                          fontWeight: FontWeight.bold),
   //                    ),
   //                    AutoSizeText(
   //                      // (salesOrder?.id?.toString() == "false")
   //                      //     ?
   // salesOrder?.amountTotal.toString()??"",
   //                       //   : salesOrder?.partnerId?.phone ?? '',
   //                      maxLines: 1,
   //                      overflow: TextOverflow.ellipsis,
   //                      style: TextStyle(
   //                        fontFamily: "cairo",
   //                        color: AppColors.black.withOpacity(0.8),
   //                        fontSize: getSize(context) / 28,
   //                      ),
   //                    )
   //                  ],
   //                ),
   //              )
   //            ],
   //          )
          ]),
        ),
      ),
    );
  }
}
