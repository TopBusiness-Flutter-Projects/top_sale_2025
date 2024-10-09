import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/direct_sell/cubit/direct_sell_state.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_category_section.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_product_section.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/scanner.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../cubit/direct_sell_cubit.dart';

class DirectSellScreen extends StatefulWidget {
  const DirectSellScreen({super.key});

  @override
  State<DirectSellScreen> createState() => _DirectSellScreenState();
}

class _DirectSellScreenState extends State<DirectSellScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectSellCubit, DirectSellState>(
        builder: (context, state) {
      var cubit = context.read<DirectSellCubit>();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: false,
          leadingWidth: 20,
          title: Text(
            "direct_sell".tr(),
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                color: AppColors.black,
                fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: Column(
            children: [
              const CustomSearchWidget(),
              SizedBox(height: 25.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomCategorySection(),
                      SizedBox(height: 25.h),
                      CustomProductSection()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
