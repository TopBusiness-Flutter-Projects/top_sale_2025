import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/details_order/cubit/delevery_orders_cubit.dart';
import 'package:top_sale/features/details_order/cubit/delevery_orders_state.dart';
import 'package:top_sale/features/details_order/screens/widgets/card_from_details_order.dart';
import 'package:top_sale/features/details_order/screens/widgets/custom_total_price.dart';
import 'package:top_sale/features/details_order/screens/widgets/product_card.dart';
import 'package:top_sale/features/details_order/screens/widgets/rounded_button.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/models/get_orders_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../delevery_order/screens/widgets/shipment_card_widget.dart';

class DetailsOrder extends StatefulWidget {
  DetailsOrder({super.key, required this.orderModel});
  bool isDelivered = false;
  final OrderModel orderModel;
  @override
  State<DetailsOrder> createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  @override
  void initState() {
    context.read<DetailsOrdersCubit>().getDetailsOrders(orderId: 38);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DetailsOrdersCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        //leadingWidth: 20,
        title: Text(
          'details_order'.tr(),
          style: TextStyle(
              fontFamily: AppStrings.fontFamily,
              color: AppColors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<DetailsOrdersCubit, DetailsOrdersState>(
          builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: getSize(context) / 33,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(
                  left: getSize(context) / 30, right: getSize(context) / 30),
              child: (cubit.getDetailsOrdersModel == null)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CardDetailsOrders(
                          orderModel: widget.orderModel,
                          orderDetailsModel: cubit.getDetailsOrdersModel!,
                        ),
                        SizedBox(
                          height: getSize(context) / 12,
                        ),
                        Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cubit
                                  .getDetailsOrdersModel!.orderLines!.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  price: 50.toString(),
                                  text: cubit.getDetailsOrdersModel
                                          ?.orderLines?[index].productId ??
                                      '',
                                  number: cubit.getDetailsOrdersModel
                                          ?.orderLines?[index].productUomQty
                                          .toString() ??
                                      '',
                                );
                              }),
                        ),
                        CustomTotalPrice(
                          price: cubit.getDetailsOrdersModel?.amountTotal
                                  .toDouble()
                                  .toString() ??
                              '',
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
                                  Navigator.pushNamed(
                                      context, Routes.paymentRoute);
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
        );
      }),
    );
  }
}
