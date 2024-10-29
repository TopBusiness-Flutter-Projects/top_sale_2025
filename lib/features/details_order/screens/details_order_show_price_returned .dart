import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/details_order/screens/widgets/card_from_details_order.dart';
import 'package:top_sale/features/details_order/screens/widgets/product_card.dart';
import 'package:top_sale/features/login/widget/custom_button.dart';
import '../../../core/models/get_orders_model.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dialogs.dart';
import '../cubit/details_orders_cubit.dart';
import '../cubit/details_orders_state.dart';
import 'widgets/custom_order_details_item.dart';

class DetailsOrderShowPriceReturns extends StatefulWidget {
  DetailsOrderShowPriceReturns(
      {super.key, required this.orderModel, required this.isClientOrder});
  bool isDelivered = false;
  bool isClientOrder;
  final OrderModel orderModel;
  @override
  State<DetailsOrderShowPriceReturns> createState() =>
      _DetailsOrderShowPriceReturnsState();
}

class _DetailsOrderShowPriceReturnsState
    extends State<DetailsOrderShowPriceReturns> {
  @override
  void initState() {
    context
        .read<DetailsOrdersCubit>()
        .getDetailsOrders(orderId: widget.orderModel.id ?? -1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsOrdersCubit, DetailsOrdersState>(
      builder: (context, state) {
        var cubit = context.read<DetailsOrdersCubit>();

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  cubit.onClickBack(context);
                },
                icon: const Icon(Icons.arrow_back)),
            backgroundColor: AppColors.white,
            centerTitle: false,
            //leadingWidth: 20,
            title: Text(
              'returns_details'.tr(),
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
                child: (cubit.getDetailsOrdersModel == null)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CardDetailsOrders(
                            isShowPrice: !widget.isClientOrder,
                            onTap: () {
                              cubit.newAllDiscountController.text =
                                  '0.0'.toString();
                              customShowBottomSheet(
                                  context, cubit.newAllDiscountController,
                                  onPressed: () {
                                if (double.parse(cubit
                                        .newAllDiscountController.text
                                        .toString()) <
                                    100) {
                                  cubit.onChnageAllDiscountOfUnit(context);
                                } else {
                                  errorGetBar('discount_validation'.tr());
                                }
                              });
                            },
                            orderModel: widget.orderModel,
                            orderDetailsModel: cubit.getDetailsOrdersModel!,
                          ),
                          SizedBox(height: getSize(context) / 12),
                          Flexible(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: cubit
                                    .getDetailsOrdersModel!.orderLines!.length,
                                itemBuilder: (context, index) {
                                  return widget.isClientOrder == true
                                      ? ProductCard(
                                          order: widget.orderModel,
                                          title: cubit.getDetailsOrdersModel
                                              ?.orderLines?[index].productName,
                                          price: cubit
                                                  .getDetailsOrdersModel
                                                  ?.orderLines?[index]
                                                  .priceSubtotal
                                                  .toString() ??
                                              '',
                                          text: cubit
                                                  .getDetailsOrdersModel
                                                  ?.orderLines?[index]
                                                  .productName ??
                                              '',
                                          number: cubit
                                                  .getDetailsOrdersModel
                                                  ?.orderLines?[index]
                                                  .productUomQty
                                                  .toString() ??
                                              '',
                                        )
                                      : CustomOrderDetailsShowPriceItem(
                                          onPressed: () {
                                            //! on delete add item tp list to send it kat reqiesu of update
                                            setState(() {
                                              cubit.removeItemFromOrderLine(
                                                  index);
                                            });
                                          },
                                          item: cubit.getDetailsOrdersModel!
                                              .orderLines![index]);
                                }),
                          ),
                        ],
                      ),
              )),
              (state is LoadingUpdateQuotation ||
                      state is LoadingConfirmQuotation)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : cubit.getDetailsOrdersModel?.orderLines?.length == 0
                      ? Container()
                      : widget.isClientOrder == true
                          ? const SizedBox()
                          : CustomButton(
                              title: 'make_order'.tr(),
                              onTap: () {
                                cubit.updateQuotation(
                                    orderModel: widget.orderModel,
                                    context: context,
                                    partnerId:
                                        widget.orderModel.partnerId?.id ?? -1);
                                //! api of update quotaion
                              },
                            ),
            ],
          ),
        );
      },
    );
  }
}
