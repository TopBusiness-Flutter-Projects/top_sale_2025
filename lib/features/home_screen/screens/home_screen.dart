import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/home_screen/screens/widgets/appbar_home.dart';
import 'package:top_sale/features/home_screen/screens/widgets/card_home.dart';
import '../../../config/routes/app_routes.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(
                  top: getSize(context) / 33,
                  left: getSize(context) / 33,
                  right: getSize(context) / 33),
              child: Column(children: [
                const AppbarHome(),
                SizedBox(
                  height: getSize(context) / 12,
                ),
                GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  children: [
                    CardHome(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.deleveryOrderRoute);
                        },
                        text: "delevey_order".tr(),
                        image: ImageAssets.deleveryOrder),
                    CardHome(
                        onPressed: () {},
                        text: "direct_sales".tr(),
                        image: ImageAssets.directSale),
                    CardHome(text: "serali_line".tr(), image: ImageAssets.line),
                    CardHome(text: "clients".tr(), image: ImageAssets.clients),
                  ],
                )
              ]),
            )),
          ),
        );
      },
    );
  }
}
