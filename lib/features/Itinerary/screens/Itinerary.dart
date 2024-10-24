import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ToggleSwitchWithLabel(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("خط السير".tr()),
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}

class ToggleSwitchWithLabel extends StatefulWidget {
  @override
  _ToggleSwitchWithLabelState createState() => _ToggleSwitchWithLabelState();
}

class _ToggleSwitchWithLabelState extends State<ToggleSwitchWithLabel> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            isSwitched ? "نهاية خط السير" : "بداية خط السير", // التبديل بين النصين
            style: TextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h), // Space between text and switch
          Switch(

            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.orange,  // اللون البرتقالي عند التبديل
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
