import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';

class CustomROW extends StatelessWidget {
  CustomROW({super.key,required this.image,required this.text,required this.text2});
  String?image;
  String?text;
  String?text2;

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(image!,width: 35.w,height: 35.h,),
                        SizedBox(width: 6.w,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(text!,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700,fontFamily: AppStrings.fontFamily),),Text(text2!,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,fontFamily: AppStrings.fontFamily),)],),],),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(),
            )]),
    );
  }
}
