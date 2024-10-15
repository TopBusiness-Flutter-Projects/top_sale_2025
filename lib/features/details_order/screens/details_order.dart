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
    context
        .read<DetailsOrdersCubit>()
        .getDetailsOrders(orderId: widget.orderModel.id ?? -1);
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
      body: BlocConsumer<DetailsOrdersCubit, DetailsOrdersState>(
          listener: (context, state) {
        if (state is ConfirmDeliveryLoadedState) {
          setState(() {
            widget.orderModel.state = 'sale';
            widget.orderModel.invoiceStatus = 'to invoice';
            widget.orderModel.deliveryStatus = 'full';
          });
        }
        if (state is CreateAndValidateInvoiceLoadedState) {
          setState(() {
            widget.orderModel.state = 'sale';
            widget.orderModel.invoiceStatus = 'invoiced';
            widget.orderModel.deliveryStatus = 'full';
          });
        }  if (state is CreateAndValidateInvoiceLoadingState) {
          setState(() {
         const CircularProgressIndicator();
          });
        }if (state is ConfirmDeliveryLoadingState) {
          setState(() {
         const CircularProgressIndicator();
          });
        }
      }, builder: (context, state) {
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
                                  title: cubit.getDetailsOrdersModel
                                      ?.orderLines?[index].productName,
                                  price:cubit.getDetailsOrdersModel
                                      ?.orderLines?[index].priceSubtotal.toString()??'',
                                  text: cubit.getDetailsOrdersModel
                                          ?.orderLines?[index].productName ??
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
                                  .toString() ??
                              '',
                        ),
                        SizedBox(
                          height: getSize(context) / 12,
                        ),
                        //     تم التسليييييييييييييم
                        widget.orderModel.state == 'sale' &&
                                widget.orderModel.invoiceStatus ==
                                    'to invoice' &&
                                widget.orderModel.deliveryStatus == 'full'
                            ? Row(
                              children: [

                               Expanded(child:  Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: RoundedButton(
                                   text: 'payment'.tr(),
                                   onPressed: () {
                                     setState(() {
                                       Navigator.pushNamed(context, Routes.paymentRoute);
                                       // cubit.createAndValidateInvoice(
                                       //     orderId: widget.orderModel.id ?? -1);
                                     });
                                   },
                                   backgroundColor: AppColors.blue,
                                 ),
                               ),),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RoundedButton(
                                      text: 'invoice'.tr(),
                                      onPressed: () {
                                        setState(() {
                                          // Navigator.pushNamed(context, Routes.paymentRoute);
                                          // cubit.createAndValidateInvoice(
                                          //     orderId: widget.orderModel.id ?? -1);
                                        });
                                      },
                                      backgroundColor: AppColors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            )
                            :
                            // جديدةةةةةةةةةةةةةةة
                            widget.orderModel.state == 'sale' &&
                                    widget.orderModel.invoiceStatus ==
                                        'to invoice' &&
                                    widget.orderModel.deliveryStatus ==
                                        'pending'
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RoundedButton(
                                      text: 'delivery_confirmation'.tr(),
                                      onPressed: () {
                                        setState(() {
                                          cubit.confirmDelivery(
                                              orderId:
                                                  widget.orderModel.id ?? -1,
                                              pickingId: cubit
                                                      .getDetailsOrdersModel
                                                      ?.pickings?[0]
                                                      .pickingId ??
                                                  -1);
                                        });
                                      },
                                      backgroundColor: AppColors.orange,
                                    ),
                                  )
                                : widget.orderModel.state == 'sale' &&
                                        widget.orderModel.invoiceStatus ==
                                            'invoiced' &&
                                        widget.orderModel.deliveryStatus ==
                                            'full'
                                    ?
                                    // مكتملةةةةةةةةةةةة
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: RoundedButton(
                                          text: 'invoice'.tr(),
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          backgroundColor: AppColors.blue,
                                        ),
                                      )
                                    : const SizedBox()
                      ],
                    ),
            ))
          ],
        );
      }),
    );
  }
}
