import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/assets_manager.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/get_size.dart';

class AppbarHome extends StatelessWidget {
  const AppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(

      children: [
        Expanded(
          child: Row(
            children: [
              const CircleAvatar(backgroundImage: AssetImage(ImageAssets.user),),
              SizedBox(width: getSize(context)/33,),
              Text("مرحبا , أية عمر",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),),

            ],
          ),
        ),

        SizedBox(
          height: 20.sp,
          child: Stack(
            children: [

              Icon(Icons.notifications_none,size: 25.sp,color: AppColors.black,),
              Positioned(
                width: 13.sp,
                height: 13.sp,
                child: Container(
                  width: 10.sp,
                  height: 10.sp,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(50.sp),
                  ),
                  child: Center(child: Text("1",style: TextStyle(fontSize:10.sp ,color: AppColors.white),)),),
              ),],
          ),
        ),                     ],
    );
  }
}
