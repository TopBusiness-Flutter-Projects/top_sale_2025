import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/config/routes/app_routes.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_category_widget.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/models/all_products_model.dart';

class CustomProductSection extends StatelessWidget {
   CustomProductSection({

    super.key,
     required this.result
  });
  List<ProductModelData>? result;
  @override
  Widget build(BuildContext context) {
    String testImage =
        'https://img.freepik.com/free-photo/organic-cosmetic-product-with-dreamy-aesthetic-fresh-background_23-2151382816.jpg';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "products".tr(),
              style:
                  getBoldStyle(color: AppColors.secondPrimary, fontSize: 20.sp),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.productsRoute,
                      arguments: "products".tr());
                },
                child: Text(
                  "all".tr(),
                  style: getRegularStyle(
                      color: AppColors.orangeThirdPrimary, fontSize: 18.sp),
                )),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            children: List.generate(
              result?.length??1,
              (index) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomProductWidget(
                //  image: testImage,
                  image: result?[index].image1920.toString()??"",
                  //image: "false",
                  title: result?[index].name??"",
                  price: "100", numofadded: result?[index]?.userOrderedQuantity.toString()??"1",
                ),
              ),
            ))
        // SizedBox(
        //   height: getheightSize(context) / 8,
        //   child: ListView.separated(
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) => CustomProductWidget(
        //             image: testImage,
        //             // image: "false",
        //             title: "لحوم لحوم  لحوم",
        //           ),
        //       separatorBuilder: (context, index) => SizedBox(
        //             width: 8,
        //           ),
        //       itemCount: 10),
        // )
      ],
    );
  }
}
