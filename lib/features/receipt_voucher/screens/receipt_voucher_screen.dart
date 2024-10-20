import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/config/routes/app_routes.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/features/clients/cubit/clients_cubit.dart';
import 'package:top_sale/features/receipt_voucher/cubit/receipt_voucher_cubit.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../cubit/receipt_voucher_state.dart';

class ReceiptVoucherScreen extends StatelessWidget {
  const ReceiptVoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        title: Text(
          'receipt_voucher'.tr(),
          style: TextStyle(
              fontFamily: AppStrings.fontFamily,
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.clientsRoute,arguments: ClientsRouteEnum.receiptVoucher);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(child:
          Icon(Icons.add,size: 30.sp,color: AppColors.white,),),
        ),
      ),
      body: BlocBuilder<ReceiptVoucherCubit, ReceiptVoucherState>(
          builder: (context, state) {
        var cubit = context.read<ReceiptVoucherCubit>();
        return Padding(
          padding: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp),
          child: Column(
            children: [
              CustomTextField(
                controller: cubit.searchController,
                //onChanged: cubit.onChangeSearch,
                labelText: "search_product".tr(),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 35,
                  color: AppColors.gray2,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  EdgeInsets.only(left: 10.0.sp, right: 10.0.sp,bottom: 10.0.sp),
                        child: Container(
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                Colors.black.withOpacity(0.1), // لون الظل مع تقليل الشفافية
                                spreadRadius: 1, // مدى انتشار الظل
                                blurRadius: 1, // مدى نعومة الظل
                                offset: const Offset(0, 1), // الاتجاه الأفقي والرأسي للظل
                              ),
                            ],
                          ),

                          child: Row(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.sp,
                                    backgroundColor: AppColors.white,
                                    child: Image.asset(ImageAssets.user),
                                  ),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "اسم العميل رقم 1".tr(),
                                        style: TextStyle(
                                            fontFamily: AppStrings.fontFamily,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        "01026267450".tr(),
                                        style: TextStyle(
                                            fontFamily: AppStrings.fontFamily,
                                            color: AppColors.black,
                                            fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Icon(Icons.local_print_shop_outlined,color: AppColors.orange,size: 30.sp,)
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
