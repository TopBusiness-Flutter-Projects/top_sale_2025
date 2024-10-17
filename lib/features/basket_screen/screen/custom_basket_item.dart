import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/all_products_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/get_size.dart';
import '../../../core/widgets/decode_image.dart';
import '../../details_order/screens/widgets/custom_order_details_item.dart';
import '../../details_order/screens/widgets/rounded_button.dart';
import '../../direct_sell/cubit/direct_sell_cubit.dart';
import '../../direct_sell/cubit/direct_sell_state.dart';
import '../../login/widget/textfield_with_text.dart';
import '../cubit/cubit.dart';

class CustomBasketItem extends StatefulWidget {
  const CustomBasketItem({required this.item, super.key});
  final ProductModelData item;
  @override
  State<CustomBasketItem> createState() => _CustomBasketItemState();
}

class _CustomBasketItemState extends State<CustomBasketItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectSellCubit, DirectSellState>(
      builder: (context, state) {
        var cubit = context.read<BasketCubit>();
        var cubit2 = context.read<DirectSellCubit>();
        return Container(
          height: getSize(context) / 4,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              offset: const Offset(2, 2),
              color: AppColors.grey2Color,
            )
          ], color: AppColors.white, borderRadius: BorderRadius.circular(5)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDecodedImage(
                base64String: widget.item.image1920,
                context: context,
                width: getSize(context) / 8,
                height: getSize(context) / 8,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 5.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: Text(
                              widget.item.name ?? '_',
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              cubit2.newDiscountController.text =
                                  widget.item.discount.toString();

                              customShowBottomSheet(
                                  context, cubit2.newDiscountController,
                                  onPressed: () {
                                cubit2.onChnageDiscountOfUnit(
                                    widget.item, context);
                              });

                              //! add discount

                              // customShowBottomSheet(
                              //   context,
                              //   cubit.controllerPercent,
                              //   onPressed: () {
                              //     //! set dis count to model
                              //     //! cal the new value of price
                              //     //! case all discout remove discount of itms first then make all and loop on them
                              //     //! clear controller
                              //   },
                              // );
                            },
                            child: Image.asset(
                              ImageAssets.discount,
                              width: getSize(context) / 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 5.0),
                            child: InkWell(
                                onTap: () {
                                  cubit2.newPriceController.text =
                                      widget.item.listPrice.toString();

                                  customPriceShowBottomSheet(
                                      context, cubit2.newPriceController, () {
                                    cubit2.onChnagePriceOfUnit(
                                        widget.item, context);
                                  });
                                },
                                child: Image.asset(
                                  ImageAssets.edit2Icon,
                                  width: getSize(context) / 18,
                                )),
                          ),
                          //! delete Product
                          IconButton(
                              onPressed: () async {
                                cubit2.deleteFromBasket(widget.item.id!);

                                ///!
                              },
                              icon: Icon(
                                CupertinoIcons.delete_solid,
                                color: AppColors.red,
                              ))
                        ],
                      ),
                      Flexible(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    border: Border.all(
                                        color: AppColors.orangeThirdPrimary,
                                        width: 1.8),
                                    borderRadius: BorderRadius.circular(
                                        getSize(context) / 22),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            cubit2.addAndRemoveToBasket(
                                                product: widget.item,
                                                isAdd: true);
                                            // Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: AppColors.orangeThirdPrimary,
                                            size: 30.w,
                                          ),
                                        ),
                                        //SizedBox(width: 8.w),
                                        Text(
                                            widget.item.userOrderedQuantity
                                                    .toString() ??
                                                '0',
                                            style: getBoldStyle(
                                                color: AppColors.primary,
                                                fontHeight: 1.3)),
                                        //SizedBox(width: 8.w),
                                        GestureDetector(
                                          onTap: () {
                                            cubit2.addAndRemoveToBasket(
                                                product: widget.item,
                                                isAdd: false);
                                            // Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: AppColors.orangeThirdPrimary,
                                            size: 30.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(
                                          color: AppColors.orangeThirdPrimary,
                                          width: 1.8),
                                      borderRadius: BorderRadius.circular(
                                          getSize(context) / 22),
                                    ),
                                    child: Text(
                                      '${calculateDiscountedPrice(widget.item.discount, widget.item.listPrice, widget.item.userOrderedQuantity)} ${widget.item.currencyId?.name ?? ''}',
                                      style: TextStyle(
                                        color: AppColors.orangeThirdPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//! add discount
void customShowBottomSheet(
    BuildContext context, TextEditingController controllerPercent,
    {required void Function() onPressed}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(getSize(context) / 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFieldWithTitle(
                title: "discount_rate".tr(),
                controller: controllerPercent,
                hint: "enter_the_percentage".tr(),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: getSize(context) / 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: getSize(context) / 20, right: getSize(context) / 20),
                child: RoundedButton(
                  backgroundColor: AppColors.primaryColor,
                  text: 'confirm'.tr(),
                  onPressed: onPressed,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
