import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/details_order/screens/widgets/card_from_details_order.dart';
import 'package:top_sale/features/login/widget/custom_button.dart';
import '../../../core/models/get_orders_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../cubit/details_orders_cubit.dart';
import '../cubit/details_orders_state.dart';
import 'widgets/custom_order_details_item.dart';

class DetailsOrderShowPrice extends StatefulWidget {
  DetailsOrderShowPrice({super.key, required this.orderModel});
  bool isDelivered = false;
  final OrderModel orderModel;
  @override
  State<DetailsOrderShowPrice> createState() => _DetailsOrderShowPriceState();
}

class _DetailsOrderShowPriceState extends State<DetailsOrderShowPrice> {
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
    return BlocBuilder<DetailsOrdersCubit, DetailsOrdersState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
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
                      left: getSize(context) / 30,
                      right: getSize(context) / 30),
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
                            SizedBox(height: getSize(context) / 12),
                            Flexible(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cubit.getDetailsOrdersModel!
                                      .orderLines!.length,
                                  itemBuilder: (context, index) {
                                    return CustomOrderDetailsShowPriceItem(
                                        onPressed: () {
                                          //! on delete add item tp list to send it kat reqiesu of update
                                          setState(() {
                                            cubit
                                                .removeItemFromOrderLine(index);
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
                    : CustomButton(
                        title: 'make_order'.tr(),
                        onTap: () {
                          cubit.updateQuotation(
                              context: context,
                              partnerId: widget.orderModel.partnerId?.id ?? -1);
                          //! api of update quotaion
                        },
                      )
              ],
            ));
      },
    );
  }
}
