import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/features/returns/cubit/returns_cubit.dart';
import 'package:top_sale/features/returns/cubit/returns_state.dart';
import '../../../config/routes/app_routes.dart';

class ReturnsScreen extends StatefulWidget {
  const ReturnsScreen({super.key});

  @override
  State<ReturnsScreen> createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends State<ReturnsScreen> {
  @override
  void initState() {
    context.read<ReturnsCubit>().getReturned(

    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ReturnsCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text('returns'.tr()),
        centerTitle: false,
        titleTextStyle: getBoldStyle(
          fontSize: 20.sp,
          color: AppColors.black,
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.sp),
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, Routes.deleveryOrderRoute);
          },
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
      body: BlocBuilder<ReturnsCubit, ReturnsState>(builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp),
          child: Column(
            children: [
              // CustomTextField(
              //   controller: cubit.searchController,
              //   // onChanged: cubit.onChangeSearch,
              //   labelText: "search_from_user".tr(),
              //   prefixIcon: Icon(
              //     Icons.search_rounded,
              //     size: 35,
              //     color: AppColors.gray2,
              //   ),
              // ),
              SizedBox(height: 20.h),
              cubit.returnOrderModel == null ||
                      cubit.returnOrderModel!.result == null
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.returnOrderModel!.result!.returnedOrders!.isEmpty
                      ? Center(child: Text("no_data".tr()))
                      : Expanded(
                          child: ListView.builder(
                              itemCount: cubit.returnOrderModel?.result
                                      ?.returnedOrders?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0.sp),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            left: 8.0.sp,
                                            right: 8.0.sp,
                                            top: 10.0.sp,
                                            bottom: 10.0.sp,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                blurStyle: BlurStyle.outer,
                                                color: Colors.black.withOpacity(
                                                    0.1), // لون الظل مع تقليل الشفافية
                                                spreadRadius:
                                                    1, // مدى انتشار الظل
                                                blurRadius: 4, // مدى نعومة الظل
                                                offset: const Offset(0,
                                                    1), // الاتجاه الأفقي والرأسي للظل
                                              ),
                                            ],
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [

                                                  Row(
                                                    children: [
                                                      Icon(Icons.person, color: AppColors.gray2, size: 20.sp,),
                                                      SizedBox(width: 5.sp,),
                                                      AutoSizeText(
                                                        cubit.returnOrderModel?.result?.returnedOrders?.elementAt(index).partnerName ?? "",
                                                        style: getBoldStyle(
                                                            color: AppColors.black,
                                                            fontSize: 14.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadiusDirectional.circular(8.sp),
                                                      color: AppColors.blue.withOpacity(0.5),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                      child: AutoSizeText(
                                                          cubit.returnOrderModel?.result?.returnedOrders?.elementAt(index).state ?? "",
                                                          style: getBoldStyle(
                                                              color:
                                                              AppColors.blue,
                                                              fontSize: 14.sp)),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              SizedBox(height: 10.sp,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  AutoSizeText(
                                                    cubit.returnOrderModel?.result?.returnedOrders?.elementAt(index).origin ?? "",
                                                    style: getBoldStyle(
                                                        color: AppColors.black,
                                                        fontSize: 14.sp),
                                                  ),
                                                  AutoSizeText(
                                                    (cubit.returnOrderModel?.result?.returnedOrders?.elementAt(index).dateDone == false) ? "": cubit.returnOrderModel?.result?.returnedOrders?.elementAt(index).dateDone?.substring(0, 10),
                                                    style: getBoldStyle(
                                                        color: AppColors.blue,
                                                        fontSize: 14.sp),
                                                  ),

                                                ],
                                              ),
                                            ],
                                          )),
                                    )
                                  ],
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
