import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:top_sale/features/contact_us/cubit/contact_us_state.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/assets_manager.dart';
import '../../login/widget/custom_button.dart';
import '../../login/widget/textfield_with_text.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
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
                child: Center(child: Text("تطبيق Deals هو أداة تكنولوجية مصممة لمساعدة مندوبي المبيعات في إدارة عمليات البيع، التواصل مع العملاء، وتسهيل جميع المهام المتعلقة بدورة المبيعات. ",textAlign: TextAlign.center,)),
              ),
              SizedBox(height: getSize(context) / 10),
SizedBox(
  height: 400.h,
  child: ListView.builder(itemBuilder: (BuildContext context, int index) {
    return CustomClient(image: '', text: 'dsjkbcjsb',);
  },itemCount: 3,),
)

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
class CustomClient extends StatelessWidget {
   CustomClient({super.key,required this.image,required this.text});
String image;
String text;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(ImageAssets.callIcon),
              SizedBox(width: 20.w,),
              Text(text),

            ],),
          SizedBox(height: getSize(context) / 40),

        ],
      ),
    );
  }
}

