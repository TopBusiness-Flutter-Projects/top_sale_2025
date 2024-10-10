import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/get_size.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/assets_manager.dart';
import '../../login/widget/textfield_with_text.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
class ProfileScreen extends StatefulWidget {

   ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<ProfileCubit>().name.text="nehal";
    context.read<ProfileCubit>().phone.text="01288143936";
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body:  SingleChildScrollView(
        child: BlocBuilder<ProfileCubit,ProfileState>(
          builder: (context,state) {
            return Column(
              children: [
                SizedBox(height: getSize(context)/30,),
              Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Stack(children: [
                   CircleAvatar(
                     radius: 50.sp,
                     backgroundImage: const AssetImage(ImageAssets.user),),

                 ],),
               ],
             ),
                SizedBox(height: getSize(context)/30,),

                CustomTextFieldWithTitle(
                  hint: "نهوله",
                  isModify:true,
                  controller: cubit.name,
                title: "name".tr(),
                  keyboardType: TextInputType.name,
                  readonly: true,
                ),
                SizedBox(height: getSize(context)/30,),
                CustomTextFieldWithTitle(
                  hint: "01288143936",
                  controller:  cubit.phone,
                title: "phone".tr(),
                  readonly: true,
                  isModify:true,


                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: getSize(context)/30,),

            ],);
          }
        ),

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
        // leadingWidth: 20,
        title: Text(
          "profile".tr(),
          style: getBoldStyle(
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
