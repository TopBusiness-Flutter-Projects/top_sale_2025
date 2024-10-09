import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/home_screen/screens/widgets/appbar_home.dart';
import 'package:top_sale/features/home_screen/screens/widgets/card_home.dart';
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
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2),
                  
                  shrinkWrap: true,
                  children: [
              const CardHome(text: "توصيل الطلبات", image:  ImageAssets.directSale),
              CardHome(
                  onPressed: () {

                  },
                  text: "بيع مباشر", image:  ImageAssets.directSale),
              CardHome(text: "خط سير", image:  ImageAssets.directSale),
              CardHome(text: "العملاء", image:  ImageAssets.directSale),

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
