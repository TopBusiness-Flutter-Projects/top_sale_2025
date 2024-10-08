import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/features/details_order/screens/widgets/card.dart';
import 'package:top_sale/features/details_order/screens/widgets/custom_total_price.dart';
import 'package:top_sale/features/details_order/screens/widgets/product_card.dart';
import 'package:top_sale/features/details_order/screens/widgets/rounded_button.dart';
import 'package:top_sale/features/details_order/screens/widgets/shard_appbar_app.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';

class DetailsOrder extends StatefulWidget {
  DetailsOrder({super.key});
  bool isDelivered = false;
  @override
  State<DetailsOrder> createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SharedAppBarApp(
            title: 'details_order',
          ),
          CustomDetailsCard(),
          //
          SizedBox(
            height: 15.h,
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
                itemBuilder:
                (context,index){

              return   Padding(
                padding:  EdgeInsets.all(8.0),
                child: ProductCard(text: 'توت ازرق',),
              );
            }),
          ),

          // SizedBox(
          //   height: 20.h,
          // ),
          CustomTotalPrice(price: "40",),
          SizedBox(
            height: 20.h,
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
          )
        ],
      ),
    ));
  }
}
