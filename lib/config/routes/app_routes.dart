import 'package:flutter/material.dart';
import 'package:top_sale/features/direct_sell/screens/categories_screen.dart';
import 'package:top_sale/features/direct_sell/screens/direct_sell_screen.dart';
import 'package:top_sale/features/direct_sell/screens/products_screen.dart';
import 'package:top_sale/features/clients/screens/clients_screen.dart';
import 'package:top_sale/features/login/screens/system_info_screen.dart';
import 'package:top_sale/features/home_screen/screens/home_screen.dart';
import 'package:top_sale/features/main/screens/main_screen.dart';
import 'package:top_sale/features/splash/screens/splash_screen.dart';
import '../../core/utils/app_strings.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/details_order/screens/details_order.dart';
import '../../features/details_order/screens/widgets/payment.dart';
import '../../features/delevery_order/screens/delevery_order_screen.dart';
import '../../features/login/screens/login_screen.dart';
import '../../features/on_boarding/screen/onboarding_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String mainRoute = '/main';
  static const String clientsRoute = '/clients';
  static const String homeRoute = '/home';
  static const String detailsOrder = '/orderDetails';
  static const String paymentRoute = '/payment';
  static const String deleveryOrderRoute = '/deleveryOrderRoute';
  static const String onboardingPageScreenRoute = '/onboardingPageScreenRoute';
  static const String registerScreen = '/registerScreen';
  static const String directSellRoute = '/directSellRoute';
  static const String categoriesRoute = '/categoriesRoute';
  static const String productsRoute = '/productsRoute';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      // case Routes.detailsRoute:
      //   final service = settings.arguments as ServicesModel;
      //   return MaterialPageRoute(
      //     // Extract the service model argument from the settings arguments map
      //
      //     builder: (context) => Details(service: service),
      //   );
      //
      case Routes.loginRoute:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.deleveryOrderRoute:
        return PageTransition(
          child: DeleveryOrderScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.paymentRoute:
        return PageTransition(
          child: PaymentScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.detailsOrder:
        return PageTransition(
          child: DetailsOrder(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.onboardingPageScreenRoute:
        return PageTransition(
          child: const OnBoardinScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 400),
        );
      case Routes.homeRoute:
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.mainRoute:
        return PageTransition(
          child: const Zoom(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.clientsRoute:
        return PageTransition(
          child: const ClientScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.registerScreen:
        return PageTransition(
          child: const RegisterScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.directSellRoute:
        return MaterialPageRoute(
          builder: (context) => const DirectSellScreen(),
        );
      case Routes.productsRoute:
        String categoryname = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ProductsScreen(
            categoryName: categoryname,
          ),
        );
      case Routes.categoriesRoute:
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );
      //
      // case Routes.resultOfLessonExam:
      //   ResponseOfApplyLessonExmamData model =
      //       settings.arguments as ResponseOfApplyLessonExmamData;
      //   return PageTransition(
      //     child: ResultExamLessonScreen(model: model),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     duration: const Duration(milliseconds: 800),
      //   );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
