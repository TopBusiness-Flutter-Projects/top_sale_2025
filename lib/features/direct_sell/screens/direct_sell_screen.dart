import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/features/direct_sell/cubit/direct_sell_state.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_category_section.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_product_section.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/scanner.dart';

import '../../../core/models/category_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../cubit/direct_sell_cubit.dart';

class DirectSellScreen extends StatefulWidget {
  const DirectSellScreen({super.key});

  @override
  State<DirectSellScreen> createState() => _DirectSellScreenState();
}

class _DirectSellScreenState extends State<DirectSellScreen> {
  List<CategoryModelData> ?result;

  void initState() {
    super.initState();
    context.read<DirectSellCubit>().getCategries();
    context.read<DirectSellCubit>().getAllProducts();
    print("nono");
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectSellCubit, DirectSellState>(
        builder: (context, state) {
          if (state is LoadingCatogries) {
            return const Center(child: CircularProgressIndicator());
          }
      var cubit = context.read<DirectSellCubit>();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: false,
          //leadingWidth: 20,
          title: Text(
            "direct_sell".tr(),
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                color: AppColors.black,
                fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: AppColors.white,
        body: RefreshIndicator(

            onRefresh: () async {
              context.read<DirectSellCubit>().getCategries();
              context.read<DirectSellCubit>().getAllProducts(); // Check network and refresh data
            }
          ,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Column(
              children: [
                const CustomSearchWidget(),
                SizedBox(height: 25.h),
                cubit.allProductsModel==null||cubit.catogriesModel==null?
                    Container(child: Center(child: CircularProgressIndicator(color: AppColors.orange,)),):
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        state==LoadingCatogries?
                        Center(child: CircularProgressIndicator(color: AppColors.primary,)):
                        CustomCategorySection(result: cubit.catogriesModel?.result??[],),
                        SizedBox(height: 25.h),
                        state==LoadingProduct?
                        Center(child: CircularProgressIndicator()):
                        CustomProductSection(result: cubit.allProductsModel?.result??[],)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
