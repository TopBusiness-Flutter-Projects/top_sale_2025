import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_sale/features/details_order/screens/widgets/payment_option.dart';
import 'package:top_sale/features/details_order/screens/widgets/rounded_button.dart';
import 'package:top_sale/features/details_order/screens/widgets/shard_appbar_app.dart';
import '../../../core/utils/app_colors.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key});
  @override
  State<PaymentScreen> createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SharedAppBarApp(title: "payment".tr()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PaymentOptions(),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(60.0),
        child: RoundedButton(text: 'confirm_invoice'.tr(), onPressed: () {
          setState(() {
           // Navigator.pushNamed(context, Routes.paymentRoute);
          });
        },backgroundColor: AppColors.secondPrimary,),
      ),
    ));
  }
}


