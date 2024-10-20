import 'package:flutter/material.dart';
import 'package:top_sale/features/clients/cubit/clients_cubit.dart';
import 'package:top_sale/features/contact_us/screens/contact_us_screen.dart';
import 'package:top_sale/features/direct_sell/screens/all_categories_screen.dart';
import 'package:top_sale/features/direct_sell/screens/direct_sell_screen.dart';
import 'package:top_sale/features/direct_sell/screens/products_screen.dart';
import 'package:top_sale/features/clients/screens/clients_screen.dart';
import 'package:top_sale/features/login/screens/system_info_screen.dart';
import 'package:top_sale/features/home_screen/screens/home_screen.dart';
import 'package:top_sale/features/main/screens/main_screen.dart';
import 'package:top_sale/features/notification_screen/screens/notification_screens.dart';
import 'package:top_sale/features/splash/screens/splash_screen.dart';
import 'package:top_sale/features/update_profile/screens/update_profile_screen.dart';
import '../../core/models/all_partners_for_reports_model.dart';
import '../../core/models/get_orders_model.dart';
import '../../core/utils/app_strings.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/basket_screen/screen/basket_screen.dart';
import '../../features/clients/screens/my_bills.dart';
import '../../features/clients/screens/profile_client.dart';
import '../../features/details_order/screens/details_order.dart';
import '../../features/details_order/screens/details_order_show_price.dart';
import '../../features/details_order/screens/widgets/payment.dart';
import '../../features/delevery_order/screens/delevery_order_screen.dart';
import '../../features/login/screens/login_screen.dart';
import '../../features/on_boarding/screen/onboarding_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/clients/screens/sales_screen.dart';
import '../../features/receipt_voucher/screens/receipt_voucher_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String mainRoute = '/main';
  static const String clientsRoute = '/clients';
  static const String homeRoute = '/home';
  static const String detailsOrder = '/orderDetails';
  static const String detailsOrderShowPrice = '/detailsOrderShowPrice';
  static const String paymentRoute = '/payment';
  static const String deleveryOrderRoute = '/deleveryOrderRoute';
  static const String onboardingPageScreenRoute = '/onboardingPageScreenRoute';
  static const String registerScreen = '/registerScreen';
  static const String directSellRoute = '/directSellRoute';
  static const String contactRoute = '/contactRoute';
  static const String categoriesRoute = '/categoriesRoute';
  static const String productsRoute = '/productsRoute';
  static const String updateProfileRoute = '/updateProfileRoute';
  static const String contactUsRoute = '/contactUsRoute';
  static const String notificationRoute = '/notificationRoute';
  static const String basketScreenRoute = '/basketScreen';
  static const String updateprofileRoute = '/updateprofile';
  static const String profileRoute = '/profileRoute';
  static const String profileClientRoute = '/profileClientRoute';
  static const String billsRoute = '/billsRoute';
  static const String salesRoute = '/salesRoute';
  static const String receiptVoucherRoute = '/receiptVoucherRoute';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Routes.loginRoute:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.profileRoute:
        return PageTransition(
          child: ProfileScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.updateprofileRoute:
        return PageTransition(
          child: const UpdateProfileScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.contactRoute:
        return PageTransition(
          child: ContactUsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        ); case Routes.salesRoute:
        return PageTransition(
          child: SalesScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );

      case Routes.deleveryOrderRoute:
        return MaterialPageRoute(
          builder: (context) => const DeleveryOrderScreen(),
        );
      case Routes.paymentRoute:
        return MaterialPageRoute(
          builder: (context) => const PaymentScreen(),
        );
      case Routes.detailsOrder:
        final OrderModel orderModel = settings.arguments as OrderModel;
        return MaterialPageRoute(
          builder: (context) => DetailsOrder(
            orderModel: orderModel,
          ),
        );
      case Routes.detailsOrderShowPrice:
        final OrderModel orderModel = settings.arguments as OrderModel;
        return MaterialPageRoute(
          builder: (context) => DetailsOrderShowPrice(
            orderModel: orderModel,
          ),
        );
      case Routes.onboardingPageScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const OnBoardinScreen(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (context) => const ZoomDrawerScreen(),
        );
      case Routes.clientsRoute:
        ClientsRouteEnum clientsRouteEnum = settings.arguments as ClientsRouteEnum;
        return MaterialPageRoute(
          builder: (context) => ClientScreen(clientsRouteEnum: clientsRouteEnum),
        );
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case Routes.directSellRoute:
        return MaterialPageRoute(
          builder: (context) => const DirectSellScreen(),
        );
      case Routes.productsRoute:
        List<String> categoryName = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (context) => ProductsScreen(
            categoryName: categoryName[0],
            catId: categoryName[1],
          ),
        );
      case Routes.updateProfileRoute:
        return MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen());
      case Routes.categoriesRoute:
        return MaterialPageRoute(
          builder: (context) => AllCategoriesScreen(),
        );
      case Routes.profileClientRoute:
        return MaterialPageRoute(
          builder: (context) => ProfileClient(),
        );   case Routes.billsRoute:
        return MaterialPageRoute(
          builder: (context) => MyBillsScreen(),
        );
      case Routes.basketScreenRoute:
        // List<dynamic>data = [];
        AllPartnerResults? partner = settings.arguments as AllPartnerResults?;
        return MaterialPageRoute(
            builder: (context) => BasketScreen(
                  partner: partner,
                  currency: 'EGP',
                ));
      case Routes.notificationRoute:
        return MaterialPageRoute(
          builder: (context) => NotificationScreens(),
        ); case Routes.receiptVoucherRoute:
        return MaterialPageRoute(
          builder: (context) => const ReceiptVoucherScreen(),
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
