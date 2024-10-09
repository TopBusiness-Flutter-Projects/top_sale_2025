import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:top_sale/core/utils/get_size.dart';
import '../../../core/utils/app_colors.dart';
import '../cubit/main_cubit.dart';
import '../cubit/main_states.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

 

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = context.read<MainCubit>();

    return BlocBuilder<MainCubit, MainStates>(
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
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height:70.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(getSize(context)/12),
                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black.withOpacity(0.1), // لون الظل مع تقليل الشفافية
                          spreadRadius: 1, // مدى انتشار الظل
                          blurRadius: 1, // مدى نعومة الظل
                          offset: const Offset(0, 1), // الاتجاه الأفقي والرأسي للظل
                        ),
                      ],
                    ),
                    child: FloatingNavbar(

                      itemBorderRadius: 90,
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      margin: const EdgeInsets.all(0),
                      backgroundColor: AppColors.white, // Set the background to white
                      elevation: 0,
                      selectedBackgroundColor: AppColors.orange,



                      items: [
                        FloatingNavbarItem(

                          customWidget: _buildNavItem(
                            context,
                            icon: Icons.menu,
                            isActive: cubit.currentIndex == 0,
                            label: "",
                          ),
                        ),
                        FloatingNavbarItem(
                          customWidget: _buildNavItem(
                            context,
                            icon: CupertinoIcons.person_alt,
                            isActive: cubit.currentIndex == 1,
                            label: "",
                          ),
                        ),
                        FloatingNavbarItem(
                          customWidget: _buildNavItem(
                            context,
                            icon: Icons.shopping_cart,
                            isActive: cubit.currentIndex == 2,
                            label: "",
                          ),
                        ),

                        FloatingNavbarItem(
                          customWidget: _buildNavItem(
                            context,
                            icon: CupertinoIcons.house_fill,
                            isActive: cubit.currentIndex == 3,
                            label: "",
                          ),
                        ),
                      ],
                      onTap: (index) {
                        setState(() {
                          cubit.currentIndex = index;
                        });
                      },
                      currentIndex: cubit.currentIndex,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
                color: isActive ? AppColors.white : AppColors.primary, // Change icon color when active
                size: getSize(context) / 15,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
