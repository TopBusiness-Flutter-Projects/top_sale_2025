import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_strings.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/core/utils/hex_color.dart';
import 'package:top_sale/features/clients/screens/widgets/custom_row_profile_client.dart';

import '../cubit/clients_cubit.dart';
import '../cubit/clients_state.dart';

class ProfileClient extends StatefulWidget {
  const ProfileClient({super.key});

  @override
  State<ProfileClient> createState() => _ProfileClientState();
}

class _ProfileClientState extends State<ProfileClient> {
  @override
  void initState() {
    // TODO: implement initState
context.read<ClientsCubit>().getParent();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ClientsCubit>();
    return BlocBuilder<ClientsCubit, ClientsState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child:
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       colors: [
                  //         HexColor("#1E487F"),
                  //         HexColor("#ABCFFF"), // First color (hex #1E487F)
                  //       ],
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //       stops: [0.1, 1], // Positions for the gradient stops
                  //     ),
                  //     borderRadius: BorderRadius.only(
                  //       bottomLeft: Radius.circular(100),
                  //       bottomRight: Radius.circular(100),
                  //     ),
                  //   ),
                  //   height: 180.h,
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Icon(Icons.arrow_back, color: AppColors.white),
                  //         SizedBox(width: 10.w),
                  //         Text(
                  //           "profile_account".tr(),
                  //           style: TextStyle(
                  //               color: AppColors.white,
                  //               fontSize: 20.sp,
                  //               fontWeight: FontWeight.w700),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Stack(children:[

                    Image.asset(ImageAssets.profileBack,width: double.infinity,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                              child: Icon(Icons.arrow_back, color: AppColors.white)),
                          SizedBox(width: 10.w),
                          Text(
                            "profile_account".tr(),
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Positioned(
                      bottom: -20,
                      left: 50,
                      right: 50,
                      child: Center(
                          child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          ImageAssets.profileIconPng,
                        ),
                      ))),
                ],
              ),

              SizedBox(
                height: 25.h,
              ),
             if( cubit.partnerModel==null)CircularProgressIndicator(color: AppColors.secondPrimary,)
             else ...[
               Text(cubit.partnerModel?.name.toString()??"",
                   style: TextStyle(
                       fontWeight: FontWeight.w700,
                       color: AppColors.black,
                       fontSize: 16.sp,
                       fontFamily: AppStrings.fontFamily)),
               Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: Text(cubit.partnerModel?.phone.toString()??"",
                     style: TextStyle(
                         fontWeight: FontWeight.w400,
                         color: AppColors.orange,
                         fontSize: 16.sp,
                         fontFamily: AppStrings.fontFamily)),
               ),
               SizedBox(
                 height: 30.h,
               ),
               GestureDetector(
                 onTap: () {
                   context.read<ClientsCubit>().openGoogleMapsRoute(
                     context.read<ClientsCubit>().lat ?? 0.0,
                     context.read<ClientsCubit>().lang ??  0.0,
                     context.read<ClientsCubit>().partnerModel?.latitude ?? 0.0,
                     context.read<ClientsCubit>().partnerModel?.longitude ?? 0.0,
                   );
                 },
                 child: CustomROW(
                   image: cubit.Images[0],
                   text: cubit.Texts[0].tr(), text2: cubit.partnerModel?.street.toString(),
                 ),
               ),  CustomROW(
                 image: cubit.Images[1],
                 text: cubit.Texts[1].tr(), text2:cubit.partnerModel?.invoiceCount.toString() ,
               ),  CustomROW(
                 image: cubit.Images[2],
                 text: cubit.Texts[2].tr(),
                 text2: cubit.partnerModel?.salesOrderCount.toString(),
               ),  CustomROW(
                 image: cubit.Images[3],
                 text: cubit.Texts[3].tr(),
                 text2: cubit.partnerModel?.dueAmount.toString(),
               ),  CustomROW(
                 image: cubit.Images[4],
                 text: cubit.Texts[4].tr(),
                 text2: cubit.partnerModel?.creditToInvoice.toString(),
               ),
               CustomROW(
                 image: cubit.Images[5],
                 text: cubit.Texts[5].tr(),text2: cubit.partnerModel?.overdueAmount.toString(),
               ),
             ]
            ],
          ),
        ),
      ));
    });
  }
}
