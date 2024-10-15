import 'package:flutter/material.dart';
import '../../../../core/models/all_partners_for_reports_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/get_size.dart';

class CustomCardClient extends StatelessWidget {
  const CustomCardClient({this.partner, super.key});
  final AllPartnerResults? partner;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            partner?.name.toString() ?? '',
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: getSize(context) / 30),
          ),
          Text(
            partner?.phone.toString() == 'false'
                ? '_'
                : partner?.phone.toString() ?? '',
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontSize: getSize(context) / 30),
          ),
          SizedBox(height: getSize(context) / 30),
          Divider(
            color: AppColors.primary.withOpacity(0.2),
            indent: getSize(context) / 50,
            endIndent: getSize(context) / 50,
          )
        ],
      ),
    );
  }
}
