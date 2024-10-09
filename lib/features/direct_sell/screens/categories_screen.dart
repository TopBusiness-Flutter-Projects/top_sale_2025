import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/direct_sell/cubit/direct_sell_state.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_category_section.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_category_widget.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_product_section.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/scanner.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../cubit/direct_sell_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    String testImage =
        'https://img.freepik.com/free-photo/organic-cosmetic-product-with-dreamy-aesthetic-fresh-background_23-2151382816.jpg';

    return BlocBuilder<DirectSellCubit, DirectSellState>(
        builder: (context, state) {
      var cubit = context.read<DirectSellCubit>();
      return Scaffold(
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
            "categories".tr(),
            style: getBoldStyle(
              fontSize: 20.sp,
            ),
          ),
        ),
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: SingleChildScrollView(
              child: StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  children: List.generate(
                    50,
                    (index) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomCategoryScreenWidget(
                        image: testImage,
                        // image: "false",
                        title: "لحوم لحوم  لحوم",
                      ),
                    ),
                  ))),
        ),
      );
    });
  }
}
