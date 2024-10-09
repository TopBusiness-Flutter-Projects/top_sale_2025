import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/config/routes/app_routes.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/core/utils/get_size.dart';

class CustomCategoryWidget extends StatelessWidget {
  const CustomCategoryWidget({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.productsRoute, arguments: title);
      },
      child: Column(
        children: [
          Container(
              height: getheightSize(context) / 12,
              width: getheightSize(context) / 12,
              decoration: BoxDecoration(
                  color: AppColors.orangeThirdPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.orangeThirdPrimary, width: 1.8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: image == "false"
                    ? Center(
                        child: Text(title.substring(0, title.indexOf(" ")),
                            style: getBoldStyle(
                                color: AppColors.white, fontSize: 18.sp)),
                      )
                    : Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
              )),
          Flexible(
            child: SizedBox(
                width: getheightSize(context) / 12,
                child: AutoSizeText(title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: getBoldStyle(fontSize: 18.sp))),
          ),
        ],
      ),
    );
  }
}

class CustomCategoryScreenWidget extends StatelessWidget {
  const CustomCategoryScreenWidget({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.productsRoute, arguments: title);
      },
      child: Column(
        children: [
          Container(
              height: getheightSize(context) / 12,
              width: getheightSize(context) / 12,
              decoration: BoxDecoration(
                  color: AppColors.orangeThirdPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.orangeThirdPrimary, width: 1.8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: image == "false"
                    ? Center(
                        child: Text(title.substring(0, title.indexOf(" ")),
                            style: getBoldStyle(
                                color: AppColors.white, fontSize: 18.sp)),
                      )
                    : Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
              )),
          Text(title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: getBoldStyle(fontSize: 16.sp)),
        ],
      ),
    );
  }
}
