import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/utils/assets_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/get_size.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() {
    _getStoreUser();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(seconds: 3, milliseconds: 500),
      () {
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('onBoarding') == true) {
      if (prefs.getString('user') != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.mainRoute, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.loginRoute, (route) => false);
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.onboardingPageScreenRoute,
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: SizedBox(
                child: Image.asset(
                  ImageAssets.logoImage,
                  height: getSize(context) / 1.4,
                  width: getSize(context) / 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomSheet: Container(
      //   color: AppColors.white,
      //   height: getSize(context) / 10,
      //   child: Image.asset(ImageAssets.topbusinessImage),
      // ),
    );
    //   },
    // );
  }
}
