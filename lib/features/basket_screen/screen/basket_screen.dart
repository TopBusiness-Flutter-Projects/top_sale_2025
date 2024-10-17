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
import 'custom_basket_item.dart';

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
                            customShowBottomSheet(context, cubit);
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
                      return CustomBasketItem(item: item);
                    },
                  ),
                  SizedBox(height: 32.h),

                  (state is LoadingCreateQuotation)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : cubit2.basket.isEmpty
                          ? Container()
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

  Future<void> launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(phoneUri)) {
      throw 'Could not launch phone dialer for $phoneNumber';
    }
  }
}
