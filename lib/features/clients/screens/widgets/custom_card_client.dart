import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/get_size.dart';
class CustomCardClient extends StatelessWidget {
  const CustomCardClient({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "اسم العميل رقم 1",
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: getSize(context) / 30),
          ),
          Text(
            "01000000000    /    01000000000",
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontSize: getSize(context) / 30),
          ),
          SizedBox(height: getSize(context) / 30),
          Divider(color: AppColors.primary.withOpacity(0.2),
          indent: getSize(context)/50,
            endIndent: getSize(context)/50,
          )
        ],
      ),
    );
  }
}
