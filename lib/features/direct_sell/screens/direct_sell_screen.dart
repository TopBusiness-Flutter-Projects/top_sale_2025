import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_sale/features/direct_sell/cubit/direct_sell_state.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_category_section.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/custom_product_section.dart';
import 'package:top_sale/features/direct_sell/screens/widgets/scanner.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/category_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/get_size.dart';
import '../../clients/screens/clients_screen.dart';
import '../cubit/direct_sell_cubit.dart';

class DirectSellScreen extends StatefulWidget {
  const DirectSellScreen({super.key});

  @override
  State<DirectSellScreen> createState() => _DirectSellScreenState();
}

class _DirectSellScreenState extends State<DirectSellScreen> {
  List<CategoryModelData>? result;

  void initState() {
    super.initState();

    context.read<DirectSellCubit>().getCategries();
    context.read<DirectSellCubit>().getAllProducts(isHome: true);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectSellCubit, DirectSellState>(
        builder: (context, state) {
      // if (state is LoadingCatogries) {
      //   return Scaffold(body: const Center(child: CircularProgressIndicator()));
      // }

      var cubit = context.read<DirectSellCubit>();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          actions: [
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, Routes.clientsRoute);
                // ClientScreen(isCart: true);
              },
              child:  Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/images/basket1.png',
                  width: getSize(context) / 15,
                  color: cubit.currentIndex == 1
                      ? AppColors.orange
                      : Colors.black,
                ),
              ),
            ),
          ],
          centerTitle: false,
          title: Text(
            "direct_sell".tr(),
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                color: AppColors.black,
                fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: AppColors.white,
        body: state is LoadingCatogries
            ? Center(
                child: CircularProgressIndicator(
                color: AppColors.primary,
              ))
            : RefreshIndicator(
                onRefresh: () async {
                  // Ensure both methods are awaited for proper refresh functionality
                  await cubit.getCategries();
                  await cubit.getAllProducts(isHome: true);
                },
                child: cubit.allProductsModel == null ||
                        cubit.catogriesModel == null
                    ? Center(
                        child:
                            CircularProgressIndicator(color: AppColors.primary))
                    : SingleChildScrollView(
                        physics:
                            const AlwaysScrollableScrollPhysics(), // Ensures the RefreshIndicator works even if the list is not scrollable
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 6),
                          child: Column(
                            children: [
                              const CustomSearchWidget(),
                              SizedBox(height: 25.h),
                              state == LoadingCatogries
                                  ? Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.primary))
                                  : CustomCategorySection(
                                      result:
                                          cubit.catogriesModel?.result ?? [],
                                    ),
                              SizedBox(height: 25.h),
                              state == LoadingProduct
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : CustomProductSection(
                                      result: cubit.homeProductsModel?.result ??
                                          []),
                            ],
                          ),
                        ),
                      ),
              ),
      );
    });
  }
}
