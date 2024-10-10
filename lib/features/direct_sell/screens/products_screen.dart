import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/features/direct_sell/cubit/direct_sell_state.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/scanner.dart';

import '../../../core/utils/app_colors.dart';
import '../cubit/direct_sell_cubit.dart';
import 'widgets/custom_product_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.categoryName});
  final String categoryName;
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
            widget.categoryName,
            style: getBoldStyle(
              fontSize: 20.sp,
            ),
          ),
        ),
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: Column(
            children: [
              const CustomSearchWidget(),
              SizedBox(
                height: 15.h,
              ),
              if (widget.categoryName == "products".tr())
                SizedBox(
                  height: 50.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.changeIndex(-1);
                        },
                        child: CustomCategoryText(
                            text: "all".tr(),
                            isSelected: cubit.currentIndex == -1),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10.w,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              cubit.changeIndex(index);
                            },
                            child: CustomCategoryText(
                                text: "لحوم",
                                isSelected: cubit.currentIndex == index),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      children: List.generate(
                        10,
                        (index) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomProductWidget(
                            image: testImage,
                            //image: "false",
                            title: "لحوم لحوم لحوم لحوم",
                            price: "100",
                          ),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class CustomCategoryText extends StatelessWidget {
  const CustomCategoryText({
    super.key,
    required this.text,
    required this.isSelected,
  });
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: getMediumStyle(
              fontSize: 18.sp,
              color: isSelected ? AppColors.red : AppColors.primaryText),
        ),
        // IntrinsicHeight(
        //   child: Container(
        //     height: 4.h,
        //     //  width: double.maxFinite,
        //     decoration: BoxDecoration(
        //       color: AppColors.red,
        //       borderRadius: BorderRadius.circular(15.sp),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
