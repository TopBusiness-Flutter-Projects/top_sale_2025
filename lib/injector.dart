import 'package:dio/dio.dart';
import 'package:top_sale/features/direct_sell/cubit/direct_sell_cubit.dart';
import 'package:top_sale/features/home_screen/cubit/cubit.dart';
import 'package:top_sale/features/login/cubit/cubit.dart';
import 'package:top_sale/features/splash/cubit/cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:top_sale/core/remote/service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'features/basket_screen/cubit/cubit.dart';
import 'features/delevery_order/cubit/delevery_orders_cubit.dart';
import 'features/main/cubit/main_cubit.dart';
import 'features/notification_screen/cubit/notification_cubit.dart';
import 'features/on_boarding/cubit/onboarding_cubit.dart';

// import 'features/downloads_videos/cubit/downloads_videos_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(() => SplashCubit());
  serviceLocator.registerFactory(() => LoginCubit(serviceLocator()));
  serviceLocator.registerFactory(() => HomeCubit(serviceLocator()));
  serviceLocator.registerFactory(() => NotificationCubit(serviceLocator()));
  serviceLocator.registerFactory(() => OnboardingCubit());
  serviceLocator.registerFactory(() => DeleveryOrdersCubit());
  serviceLocator.registerFactory(() => DirectSellCubit());
  serviceLocator.registerFactory(() => MainCubit(serviceLocator()));
  serviceLocator.registerFactory(() => BasketCubit(serviceLocator()));

  ///////////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
