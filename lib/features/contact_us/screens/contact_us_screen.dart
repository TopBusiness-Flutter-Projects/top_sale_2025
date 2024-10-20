import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_strings.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:top_sale/features/contact_us/cubit/contact_us_state.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/assets_manager.dart';
class ContactUsScreen extends StatelessWidget {
   ContactUsScreen({super.key});
   final String phoneNumber = '01288143936'; // replace with actual phone number
   final String email = 'nehal123@gmail.com'; // replace with actual email
   final String whatsAppNumber = '01288143936';
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ContactUsCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: BlocBuilder<ContactUsCubit, ContactUsState>(
            builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          //    SizedBox(height: getSize(context) / 10,),
              Image.asset(ImageAssets.topBusinessLogo,scale: 4,),
              SizedBox(height: getSize(context) / 40),
              SizedBox(height: getSize(context) / 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Unlock Your Business For Potential",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                      fontFamily: AppStrings.fontFamily2,// Example: making it bold
                    color: AppColors.primary,
                    fontSize: 20.sp// Example: changing color to blue
                ),),
              ),
              SizedBox(height: getSize(context) / 10),
ListView.builder(
  shrinkWrap: true,
  itemBuilder: (BuildContext context, int index) {
  return GestureDetector(
    onTap: () {
      if (index == 0) {
        cubit.launchURL('tel:$phoneNumber'); // Call functionality
      } else if (index == 1) {
        cubit.launchEmail(); // Email functionality
      } else if (index == 2) {
        cubit.launchURL('https://wa.me/$whatsAppNumber'); // WhatsApp functionality
      }
    },
    child: ListTile(
      leading: Image.asset(cubit.Images[index]),
      title: Text(cubit.Texts[index],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,fontFamily: AppStrings.fontFamily),),
    ),
  );
},itemCount: 3,),
              SizedBox(height: 100.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                GestureDetector(
              onTap: () => cubit.launchURL(cubit.links['youtube']!)
              ,child: Image.asset(ImageAssets.youtubeIcon)),
                SizedBox(width: 4.w,),
                  GestureDetector(
                      onTap: () => cubit.launchURL(cubit.links['web']!),
                      child: Image.asset(ImageAssets.webIcon)),
                SizedBox(width: 4.w,) ,
                  GestureDetector(
                      onTap: () => cubit.launchURL(cubit.links['instagram']!),
                      child: Image.asset(ImageAssets.instgramIcon)),
                 SizedBox(width: 4.w,),
                  GestureDetector(
                      onTap: () => cubit.launchURL(cubit.links['twitter']!),
                      child: Image.asset(ImageAssets.twitterIcon)),
                 SizedBox(width: 4.w,) ,
                  GestureDetector(
                      onTap: () => cubit.launchURL(cubit.links['facebook']!),
                      child: Image.asset(ImageAssets.facebookIcon)),
              ],)

            ],
          );
        }),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_outlined,
            size: 25.w,
          ),
        ),
        // //leadingWidth: 20,
        title: Text(
          "contact".tr(),
          style: getBoldStyle(
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}

