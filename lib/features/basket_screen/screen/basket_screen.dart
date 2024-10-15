import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/basket_screen/cubit/cubit.dart';
import 'package:top_sale/features/login/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/all_partners_for_reports_model.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/widgets/decode_image.dart';
import '../../details_order/screens/widgets/rounded_button.dart';
import '../../direct_sell/cubit/direct_sell_cubit.dart';
import '../../direct_sell/cubit/direct_sell_state.dart';
import '../../login/widget/textfield_with_text.dart';
import '../cubit/state.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({required this.partner, super.key});
  final AllPartnerResults? partner;
  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectSellCubit, DirectSellState>(
      builder: (context, state) {
        var cubit = context.read<BasketCubit>();
        var cubit2 = context.read<DirectSellCubit>();

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              'basket'.tr(),
              style: TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<BasketCubit, BasketState>(
                builder: (context, state) {
              return Column(
                children: [
                  //! Cusomer name
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 14),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.grey2Color,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImageAssets.profileIconPng,
                          width: getSize(context) / 8,
                          height: getSize(context) / 8,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    widget.partner?.name ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                widget.partner?.phone.toString() == 'false'
                                    ? Container()
                                    : InkWell(
                                        onTap: () async {
                                          await launchPhoneDialer(
                                              widget.partner?.phone ?? '');
                                        },
                                        child: Text(
                                          widget.partner?.phone.toString() ??
                                              '_',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //! add discount
                            _showBottomSheet(context, cubit);
                          },
                          child: Image.asset(
                            ImageAssets.discount,
                            width: getSize(context) / 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 5.0),
                          child: Column(
                            children: [
                              Text(
                                'total'.tr(),
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                '${cubit2.totalBasket()} ج',
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )

                  //! Cusomer name
                  ,
                  SizedBox(
                    height: getSize(context) / 16,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit2.basket.length,
                    itemBuilder: (context, index) {
                      var item = cubit2.basket[index];
                      return Container(
                        height: getSize(context) / 4,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(2, 2),
                                color: AppColors.grey2Color,
                              )
                            ],
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDecodedImage(
                              base64String: item.image1920,
                              context: context,
                              width: getSize(context) / 8,
                              height: getSize(context) / 8,
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 5.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Text(
                                            item.name ?? '_',
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),

                                        InkWell(
                                          onTap: () {
                                            //! add discount

                                            _showBottomSheet(context, cubit);
                                          },
                                          child: Image.asset(
                                            ImageAssets.discount,
                                            width: getSize(context) / 14,
                                          ),
                                        ),
                                        //! delete Product
                                        Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 5.0),
                                            child: IconButton(
                                                onPressed: () async {
                                                  cubit2.basket
                                                      .removeWhere((element) {
                                                    return element.id ==
                                                        item.id;
                                                  });
                                                  setState(() {});

                                                  ///!
                                                },
                                                icon: Icon(
                                                  CupertinoIcons.delete_solid,
                                                  color: AppColors.red,
                                                )))
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
                                                      color: AppColors
                                                          .orangeThirdPrimary,
                                                      width: 1.8),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          getSize(context) /
                                                              22),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cubit2
                                                              .addAndRemoveToBasket(
                                                                  product: item,
                                                                  isAdd: true);
                                                          // Navigator.pop(context);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: AppColors
                                                              .orangeThirdPrimary,
                                                          size: 30.w,
                                                        ),
                                                      ),
                                                      //SizedBox(width: 8.w),
                                                      Text(
                                                          item.userOrderedQuantity
                                                                  .toString() ??
                                                              '0',
                                                          style: getBoldStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontHeight: 1.3)),
                                                      //SizedBox(width: 8.w),
                                                      GestureDetector(
                                                        onTap: () {
                                                          cubit2
                                                              .addAndRemoveToBasket(
                                                                  product: item,
                                                                  isAdd: false);
                                                          // Navigator.pop(context);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: AppColors
                                                              .orangeThirdPrimary,
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
                                                  margin:
                                                      const EdgeInsetsDirectional
                                                          .only(start: 10),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    border: Border.all(
                                                        color: AppColors
                                                            .orangeThirdPrimary,
                                                        width: 1.8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            getSize(context) /
                                                                22),
                                                  ),
                                                  child: Text(
                                                    '${((item.listPrice ?? 1) * item.userOrderedQuantity).toString() ?? '-1'} ج',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .orangeThirdPrimary,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                  ),
                  SizedBox(height: 32.h),

                  (state is LoadingCreateQuotation)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          title: 'show_price'.tr(),
                          onTap: () {
                            cubit2.createQuotation(
                                context: context,
                                partnerId: widget.partner?.id ?? -1);
                            //!
                          })
                ],
              );
            }),
          ),
        );
      },
    );
  }

  //! add discount
  void _showBottomSheet(BuildContext context, BasketCubit cubit) {
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
                  controller: cubit.controllerPercent,
                  hint: "enter_the_percentage".tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: getSize(context) / 30,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: getSize(context) / 20,
                      right: getSize(context) / 20),
                  child: RoundedButton(
                    backgroundColor: AppColors.primaryColor,
                    text: 'confirm'.tr(),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(phoneUri)) {
      throw 'Could not launch phone dialer for $phoneNumber';
    }
  }
}
