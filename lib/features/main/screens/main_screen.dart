import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:top_sale/core/utils/get_size.dart';
import 'package:top_sale/features/main/widget/menu_screen_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../cubit/main_cubit.dart';
import '../cubit/main_states.dart';

final ZoomDrawerController z = ZoomDrawerController();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    MainCubit cubit = context.read<MainCubit>();

    return ZoomDrawer(
      borderRadius: 50,
      // showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      menuScreenTapClose: true,
      // angle: 0.0,
      menuBackgroundColor: Colors.blue,
      menuScreen: MenuScreenWidget(
        closeClick: () => z.close?.call(),
      ),
      mainScreen: BlocBuilder<MainCubit, MainStates>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Scaffold(
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
                          // activeIndex: cubit.currentIndex,
                          // gapLocation: GapLocation.center,
                          // notchSmoothness: NotchSmoothness.verySmoothEdge,
                          onTap: (index) {
                            if (cubit.currentIndex == 3) {
                              z.toggle?.call();
                              cubit.changeNavigationBar(index);
                            } else {
                              cubit.changeNavigationBar(index);
                            }
                          },
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper function to build each navigation item
  Widget _buildNavItem(BuildContext context,
      {required IconData icon, required bool isActive, required String label}) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: isActive
                ? BoxDecoration(
                    color: AppColors.orange, // Highlight color for active item
                    borderRadius: BorderRadius.circular(90),
                  )
                : null,
            child: Padding(
              padding: EdgeInsets.all(5.h),
              child: Icon(
                icon,
                color: isActive
                    ? AppColors.white
                    : AppColors.primary, // Change icon color when active
                size: getSize(context) / 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
