import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/features/delevery_order/screens/delevery_order_screen.dart';
import '../../../core/remote/service.dart';
import '../../home_screen/screens/home_screen.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit(this.api) : super(MainInitialState());
  ServiceApi api;

  int currentIndex = 0;

  List<Widget> navigationBarViews = const [
    HomeScreen(),
    HomeScreen(),
    DeleveryOrderScreen(),
    HomeScreen(),
  ];
  void getHomePage() {
    currentIndex = 0;
  }

  void changeNavigationBar(int index) {
    currentIndex = index;
    emit(AppNavBarChangeState());
  }
}
