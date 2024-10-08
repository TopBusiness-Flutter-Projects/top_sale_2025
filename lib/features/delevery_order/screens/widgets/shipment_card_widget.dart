import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/get_size.dart';

class ShipmentCardWidget extends StatelessWidget {
  ShipmentCardWidget(
      {super.key,
      required this.status,
      required this.backgroundColor,
      required this.textColor});
  DateTime currentBackPressTime = DateTime.now(); // تاريخ ووقت الحالي
  final String status;
  final Color backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSize(context),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // لون الظل مع تقليل الشفافية
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
                        fontFamily: "Tajawal",
                        color: AppColors.blue,
                        fontSize: getSize(context) / 25,
                      ),
                    ),
                    SizedBox(width: getSize(context) / 60),
                    Expanded(
                      child: AutoSizeText(
                        "123456",
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "Tajawal",
                          color: AppColors.black,
                          fontSize: getSize(context) / 28,
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
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(getSize(context) / 20)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(getSize(context) / 200),
                    child: AutoSizeText(
                      status,
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: getSize(context) / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(ImageAssets.dateIcon),
                  SizedBox(width: getSize(context) / 60),
                  AutoSizeText(
                    DateFormat('dd/MM/yyyy').format(currentBackPressTime),
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      color: AppColors.black,
                      fontSize: getSize(context) / 28,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AutoSizeText(
                    "total".tr(),
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      color: AppColors.blue,
                      fontSize: getSize(context) / 25,
                    ),
                  ),
                  SizedBox(width: getSize(context) / 60),
                  AutoSizeText(
                    "40 \$",
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      color: AppColors.black,
                      fontSize: getSize(context) / 28,
                    ),
                  ),
                ],
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
                      "اسم العميل ",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: getSize(context) / 25,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    AutoSizeText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "01000000000/01000000000 ",
                      style: TextStyle(
                        fontFamily: "Tajawal",
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
    );
  }
}
