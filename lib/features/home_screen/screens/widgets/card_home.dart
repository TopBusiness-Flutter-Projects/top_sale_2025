import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/get_size.dart';

class CardHome extends StatelessWidget {
  const CardHome({super.key, required this.text, required this.image, this.onPressed});
final String text;
final String image;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return    GestureDetector(

      onTap: onPressed,
      child: Container(

        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // لون الظل مع تقليل الشفافية
                spreadRadius: 1, // مدى انتشار الظل
                blurRadius: 1, // مدى نعومة الظل
                offset: const Offset(0, 1), // الاتجاه الأفقي والرأسي للظل
              ),
            ],
            borderRadius: BorderRadiusDirectional.circular(
                getSize(context) / 20),
            color: AppColors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image),
            SizedBox(height: getSize(context)/20,),
             Text(text)
          ],),
      ),
    );
  }
}
