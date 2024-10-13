import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/models/get_orders_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/get_size.dart';

class ShipmentCardWidget extends StatelessWidget {
  ShipmentCardWidget(
      {super.key, required this.order, required this.isDeleveryOrder});
  OrderModel order;

  final bool isDeleveryOrder;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isDeleveryOrder
            ? Navigator.pushNamed(context, Routes.detailsOrder)
            : Container();
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
                          order.displayName ?? '',
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
                isDeleveryOrder
                    ? Container(
                        height: getSize(context) / 15,
                        width: getSize(context) / 5,
                        decoration: BoxDecoration(
                            color: order.state == "sale" &&
                                    order.invoiceStatus == "to invoice" &&
                                    order.deliveryStatus == "full"
                                ? AppColors.blue.withOpacity(0.5)
                                : order.state == "sale" &&
                                        order.invoiceStatus == "invoiced" &&
                                        order.deliveryStatus == "full"
                                    ? AppColors.green.withOpacity(0.5)
                                    : order.state == "sale" &&
                                            order.invoiceStatus ==
                                                "to invoice" &&
                                            order.deliveryStatus == "pending"
                                        ? AppColors.orange.withOpacity(0.5)
                                        : AppColors.orange.withOpacity(0.5),
                            borderRadius:
                                BorderRadius.circular(getSize(context) / 20)),
                        child: Center(
                            child: Padding(
                                padding: EdgeInsets.all(getSize(context) / 200),
                                child: AutoSizeText(
                                  order.state == "sale" &&
                                          order.invoiceStatus == "to invoice" &&
                                          order.deliveryStatus == "full"
                                      ? "delivered".tr()
                                      : order.state == "sale" &&
                                              order.invoiceStatus ==
                                                  "invoiced" &&
                                              order.deliveryStatus == "full"
                                          ? "complete".tr()
                                          : order.state == "sale" &&
                                                  order.invoiceStatus ==
                                                      "to invoice" &&
                                                  order.deliveryStatus ==
                                                      "pending"
                                              ? "new".tr()
                                              : "show_price".tr(),
                                  style: TextStyle(
                                    color: order.state == "sale" &&
                                            order.invoiceStatus ==
                                                "to invoice" &&
                                            order.deliveryStatus == "full"
                                        ? AppColors.blue
                                        : order.state == "sale" &&
                                                order.invoiceStatus ==
                                                    "invoiced" &&
                                                order.deliveryStatus == "full"
                                            ? AppColors.green
                                            : order.state == "sale" &&
                                                    order.invoiceStatus ==
                                                        "to invoice" &&
                                                    order.deliveryStatus ==
                                                        "pending"
                                                ? AppColors.orange
                                                : AppColors.orange,
                                  ),
                                ))))
                    : SizedBox()
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
                        order.writeDate ?? '',
                        style: TextStyle(
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
                        "${order.amountTotal} \$",
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
                Image.asset(ImageAssets.user),
                SizedBox(width: getSize(context) / 60),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        order.partnerModel!.name ?? '',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: getSize(context) / 25,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        (order.partnerModel?.phone.toString() == "false")
                            ? '000000001/100000000'
                            : order.partnerModel?.phone ?? '',
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
