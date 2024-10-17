import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/models/all_products_model.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/core/utils/get_size.dart';

import '../../../../core/widgets/decode_image.dart';
import '../../cubit/direct_sell_cubit.dart';
import '../../cubit/direct_sell_state.dart';

class CustomProductWidget extends StatelessWidget {
  const CustomProductWidget({super.key, required this.product});
  final ProductModelData product;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectSellCubit, DirectSellState>(
      builder: (context, state) {
        var cubit = context.read<DirectSellCubit>();
        return Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: getSize(context) / 3,
                        decoration: BoxDecoration(
                            color: AppColors.orangeThirdPrimary,
                            borderRadius: BorderRadius.circular(18.r)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.r),
                            child: product.image1920.toString() == "false"
                                ? Center(
                                    child: Text(
                                        product.name!.length > 5
                                            ? product.name!.substring(0, 4)
                                            : product.name ?? '',
                                        style: getBoldStyle(
                                            color: AppColors.white,
                                            fontSize: 18.sp)),
                                  )
                                : CustomDecodedImage(
                                    context: context,
                                    base64String: product.image1920,
                                  )),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text("${product.name ?? ''}\n",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    getBoldStyle(color: AppColors.primaryGrey)),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                              "${product.listPrice.toString()}${product.currencyId?.name ?? ''}",
                              // maxLines: 2,
                              // textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: getRegularStyle(
                                  color: AppColors.orangeThirdPrimary)),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                              color: AppColors.orangeThirdPrimary, width: 1.8),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pop(context);

//! add
                                  cubit.addAndRemoveToBasket(
                                      product: product, isAdd: true);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.orangeThirdPrimary,
                                  size: 30.w,
                                ),
                              ),
                              //SizedBox(width: 8.w),
                              Text(product.userOrderedQuantity.toString(),
                                  style: getBoldStyle(
                                      color: AppColors.primary,
                                      fontHeight: 1.3)),
//SizedBox(width: 8.w),
                              GestureDetector(
                                onTap: () {
                                  cubit.addAndRemoveToBasket(
                                      product: product, isAdd: false);
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
                      )
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }
}
