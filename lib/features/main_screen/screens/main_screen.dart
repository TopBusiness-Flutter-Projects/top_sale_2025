import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/features/main_screen/cubit/cubit.dart';
import 'package:top_sale/features/main_screen/cubit/state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          //! Push with Navigator.pushNamed(context, Routes.mainRoute);

                          //! set here Main orders (sanaa)
                        },
                        child: const Text('Orders')),
                    TextButton(
                        onPressed: () {
                          //! Push with Navigator.pushNamed(context, Routes.mainRoute);
                          //! set here Main orders (nehal)
                        },
                        child: const Text('Order details')),
                  ]),
            ));
      },
    );
  }
}
