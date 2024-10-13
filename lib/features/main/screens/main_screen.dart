import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/main/widget/menu_screen_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../cubit/main_cubit.dart';

ZoomDrawerController z = ZoomDrawerController();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = context.read<MainCubit>();

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: true,
              extendBody: true,
              body: WillPopScope(
                onWillPop: () async {
                  if (cubit.currentIndex != 0) {
                    setState(() {
                      cubit.currentIndex = 0;
                    });
                    return false;
                  } else {
                    SystemNavigator.pop();
                    return true;
                  }
                },
                child: cubit.navigationBarViews[cubit.currentIndex],
              ),
              bottomNavigationBar: Directionality(
                textDirection: TextDirection.ltr,
                child: Material(
                  elevation: 50,
                  shadowColor: Colors.grey,
                  child: SalomonBottomBar(
                    items: [
                      /// Home
                      SalomonBottomBarItem(
                        icon: Image.asset(
                          'assets/images/home1.png',
                          width: getSize(context) / 22,
                          color: cubit.currentIndex == 0
                              ? AppColors.orange
                              : Colors.black,
                        ),
                        title: Text('home'.tr()),
                        selectedColor: AppColors.orange,
                      ),

                      /// Likes
                      SalomonBottomBarItem(
                        icon: Image.asset(
                          'assets/images/basket1.png',
                          width: getSize(context) / 22,
                          color: cubit.currentIndex == 1
                              ? AppColors.orange
                              : Colors.black,
                        ),
                        title: Text('basket'.tr()),
                        selectedColor: AppColors.orange,
                      ),

                      /// Search
                      SalomonBottomBarItem(
                        icon: Image.asset(
                          'assets/images/hr1.png',
                          width: getSize(context) / 22,
                          color: cubit.currentIndex == 2
                              ? AppColors.orange
                              : Colors.black,
                        ),
                        title: Text('hr'.tr()),
                        selectedColor: AppColors.orange,
                      ),

                      /// Profile
                      SalomonBottomBarItem(
                        icon: Image.asset(
                          'assets/images/menu1.png',
                          width: getSize(context) / 22,
                          color: cubit.currentIndex == 3
                              ? AppColors.orange
                              : Colors.black,
                        ),
                        title: Text('menu'.tr()),
                        selectedColor: AppColors.orange,
                      ),
                    ],
                    backgroundColor: Colors.white70,
                    currentIndex: cubit.currentIndex,
                    onTap: (index) {
                      setState(() {
                        if (index == 3) {
                          // print(z.)
                          z.open!();
                        } else {
                          cubit.changeNavigationBar(index);
                        }
                      });
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class Zoom extends StatefulWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      isRtl: true,
      borderRadius: 25,
      style: DrawerStyle.defaultStyle,
      openCurve: Curves.linearToEaseOut,
      slideWidth: MediaQuery.of(context).size.width * 0.80,
      duration: const Duration(milliseconds: 700),
      angle: 0.0,
      drawerShadowsBackgroundColor: AppColors.primary,
      shadowLayer1Color: AppColors.transparent,
      shadowLayer2Color: AppColors.black.withOpacity(0.1),
      showShadow: true,
      overlayBlur: 0,
      moveMenuScreen: false,
      mainScreenTapClose: true,
      menuScreenOverlayColor: AppColors.primary,
      menuBackgroundColor: AppColors.white,
      mainScreen: const MainScreen(),
      menuScreen: MenuScreenWidget(closeClick: () => z.close?.call()),
    );
  }
}
