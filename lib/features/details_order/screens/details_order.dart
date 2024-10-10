import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/details_order/screens/widgets/custom_total_price.dart';
import 'package:top_sale/features/details_order/screens/widgets/product_card.dart';
import 'package:top_sale/features/details_order/screens/widgets/rounded_button.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../delevery_order/screens/widgets/shipment_card_widget.dart';

class DetailsOrder extends StatefulWidget {
  DetailsOrder({super.key});
  bool isDelivered = false;
  @override
  State<DetailsOrder> createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        leadingWidth: 20,
        title: Text(
          'details_order'.tr(),
          style: TextStyle(
              fontFamily: AppStrings.fontFamily,
              color: AppColors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: getSize(context) / 33,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(
                left: getSize(context) / 30, right: getSize(context) / 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShipmentCardWidget(
                  isDeleveryOrder: false,
                  backgroundColor: AppColors.orange.withOpacity(0.5),
                  textColor: AppColors.orange,
                  status: "new".tr(), // Current orders
                ),
                SizedBox(
                  height: getSize(context) / 12,
                ),
                Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          price: 50.toString(),
                          text: 'توت ازرق',
                          number: "1",
                        );
                      }),
                ),
                CustomTotalPrice(
                  price: "40",
                ),
                SizedBox(
                  height: getSize(context) / 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RoundedButton(
                    text: widget.isDelivered == false
                        ? 'delivery_confirmation'.tr()
                        : 'Create_an_invoice'.tr(),
                    onPressed: () {
                      setState(() {
                        if (widget.isDelivered == true) {
                          //!
                          Navigator.pushNamed(context, Routes.paymentRoute);
                        } else {
                          widget.isDelivered = true;
                        }
                      });
                    },
                    backgroundColor: widget.isDelivered == false
                        ? AppColors.orange
                        : AppColors.secondPrimary,
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
