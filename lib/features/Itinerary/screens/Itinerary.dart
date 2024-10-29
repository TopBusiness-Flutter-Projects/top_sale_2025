import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_sale/core/utils/app_colors.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/features/Itinerary/cubit/cubit.dart';
import 'package:top_sale/features/Itinerary/cubit/state.dart';
import 'package:top_sale/features/clients/cubit/clients_cubit.dart';
import 'package:top_sale/features/clients/cubit/clients_state.dart';
import 'package:top_sale/features/login/cubit/cubit.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ItineraryCubit, ItineraryState>(
          builder: (context, state) {
        var cubit = context.read<ItineraryCubit>();
        var cubit2 = context.read<ClientsCubit>();
        return Column(
          children: [
            Flexible(
              child: BlocBuilder<ClientsCubit, ClientsState>(
                  builder: (context, state) {
                return cubit2.currentLocation == null
                    ? const SizedBox()
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            cubit2.currentLocation != null
                                ? cubit2.currentLocation!.latitude!
                                : 0,
                            cubit2.currentLocation != null
                                ? cubit2.currentLocation!.longitude!
                                : 0,
                          ),
                          zoom: 17,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId("currentLocation"),
                            position: LatLng(
                              cubit2.currentLocation != null
                                  ? cubit2.currentLocation!.latitude!
                                  : 0,
                              cubit2.currentLocation != null
                                  ? cubit2.currentLocation!.longitude!
                                  : 0,
                            ),
                          ),
                          // Rest of the markers...
                        },
                        onMapCreated: (GoogleMapController controller) {
                          cubit!.mapController =
                              controller; // Store the GoogleMapController
                        },
                        onTap: (argument) {
                          // _customInfoWindowController.hideInfoWindow!();
                        },
                        onCameraMove: (position) {
                          // if (cubit!.strartlocation != position.target) {
                          //   print(cubit!.strartlocation);
                          //   cubit!.strartlocation = position.target;
                          //   // cubit!.getCurrentLocation();
                          // }
                          // _customInfoWindowController.hideInfoWindow!();
                        },
                      );
              }),
            ),
            const ToggleSwitchWithLabel(),
          ],
        );
      }),
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: Text("serali_line".tr()),
        centerTitle: false,
        titleTextStyle: getBoldStyle(fontSize: 20.sp),
      ),
    );
  }
}

class ToggleSwitchWithLabel extends StatefulWidget {
  const ToggleSwitchWithLabel({super.key});

  @override
  _ToggleSwitchWithLabelState createState() => _ToggleSwitchWithLabelState();
}

class _ToggleSwitchWithLabelState extends State<ToggleSwitchWithLabel> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isSwitched
                  ? "نهاية خط السير"
                  : "بداية خط السير", // التبديل بين النصين
              style: TextStyle(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10.h), // Space between text and switch
            CupertinoSwitch(
              value: isSwitched,

              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              activeColor: AppColors.orangeThirdPrimary,
              // activeColor: Colors.white,
              // activeTrackColor: Colors.orange, // اللون البرتقالي عند التبديل
              // inactiveThumbColor: Colors.white,
              // inactiveTrackColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
