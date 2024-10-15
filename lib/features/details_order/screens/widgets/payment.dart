import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:top_sale/features/details_order/screens/widgets/payment_option.dart';
import 'package:top_sale/features/details_order/screens/widgets/shard_appbar_app.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  @override
  State<PaymentScreen> createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SharedAppBarApp(title: "payment".tr()),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: PaymentOptions(

              ),
            ),
          ],
        ),

      ),
    );
  }
}


