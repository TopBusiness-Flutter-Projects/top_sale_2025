import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/models/get_last_attendance_model.dart';
import 'package:top_sale/core/remote/service.dart';
import '../../../core/models/get_all_attendance_model.dart';
import 'package:top_sale/core/utils/appwidget.dart';
import 'package:top_sale/core/utils/dialogs.dart';
import '../../../core/models/get_contract_model.dart';
import '../../../core/models/holidays_model.dart';
import 'attendance_and_departure_state.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:intl/intl.dart';

enum AttendanceAndDepartureEnum {
  workContract,
  attendanceAndDeparture,
  monthlySalaries,
  availableHolidays
}

class AttendanceAndDepartureCubit extends Cubit<AttendanceAndDepartureState> {
  AttendanceAndDepartureCubit(this.api)
      : super(AttendanceAndDepartureInitial());
  ServiceApi api;
  TextEditingController searchController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GetContractModel? contractDetails;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? fromDate;
  String? toDate;
  getContract() async {
    emit(GetContractLoading());
    final result = await api.getContract();
    result.fold(
      (failure) => emit(GetContractError()),
      (r) {
        contractDetails = r;
        emit(GetContractLoaded());
      },
    );
  }
  void onSelectedDate(bool isStartDate, BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (selectedStartDate ?? DateTime.now())
          : (selectedEndDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(9999),
    );

    if (picked != null) {
      if (isStartDate) {
        selectedStartDate = picked;
      } else {
        selectedEndDate = picked;
      }
      updateDateStrings();
      emit(DateChangedState());

      // // Call this to fetch the updated data
      // getHrDataHome();
      // context.read<AdvancesAndDiscountsCubit>().getAttendence(
      //     userId: context.read<AdvancesAndDiscountsCubit>().userIdd ?? "1",
      //     context: context);
    }
  }
  void updateDateStrings() {
    fromDate = selectedStartDate != null
        ? DateFormat('yyyy-MM-dd', 'en').format(selectedStartDate!)
        : DateFormat('yyyy-MM-dd', 'en')
        .format(DateTime.now()); // تاريخ اليوم كقيمة افتراضية

    toDate = selectedEndDate != null
        ? DateFormat('yyyy-MM-dd', 'en').format(selectedEndDate!)
        : DateFormat('yyyy-MM-dd', 'en')
        .format(DateTime.now()); // تاريخ اليوم كقيمة افتراضية

    print('From date: $fromDate, To date: $toDate');
  }
  GetAllAttendanceModel getAllAttendanceModel = GetAllAttendanceModel();
  void getAllAttendance() async {
    emit(GetAllAttendanceLoadingState());
    final result = await api.getAllAttendance();
    result.fold(
          (failure) =>
          emit(GetAllAttendanceErrorState()),
          (r) {
            if (r.attendances == null){

            }else{
              getAllAttendanceModel = r;
            }

        emit(GetAllAttendanceLoadedState());
      },
    );
  }
  HolidaysModel holidaysModel = HolidaysModel();
  void getAllHolidays() async {
    emit(GetAllHolidaysLoadingState());
    final result = await api.getHolidays();
    result.fold(
          (failure) =>
          emit(GetAllHolidaysErrorState()),
          (r) {
            holidaysModel = r;
        emit(GetAllHolidaysLoadedState());
      },
    );
  }
 

  final info = NetworkInfo();
  String wifiIPP = '';
  String convertToEnglishDigits(String input) {
    const Map<String, String> arabicToEnglishDigits = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    String output = input;
    arabicToEnglishDigits.forEach((arabic, english) {
      output = output.replaceAll(arabic, english);
    });

    return output;
  }

  // Your getIp method
  Future<void> getIp() async {
    String wifiIP = await info.getWifiIP() ?? "";
    wifiIPP = convertToEnglishDigits(wifiIP); // Convert to Western digits
    print("WIFIIP:  $wifiIPP");
    emit(GetWifiIPLoaded());
  }

  checkInOut(
    BuildContext context, {
    required bool isChechIn,
    required double lat,
    required double long,
    required String country,
    required String city,
  }) async {
    // getIp();
    AppWidget.createProgressDialog(context, "جاري التحميل ..");
    emit(CheckInOutLoading());
    final result = await api.checkInOutt(
      city: city,
      country: country,
      ip: wifiIPP,
      lat: lat,
      long: long,
      isChechIn: isChechIn,
    );
    result.fold(
      (failure) {
        Navigator.pop(context);
        errorGetBar("error".tr());
        emit(CheckInOutError());
      },
      (r) {
        Navigator.pop(context);
        if (r.result != null) {
          if (r.result!.message != null) {
            getLastAttendanceModel!.lastAttendance!.status =
                isChechIn ? "check-in" : "check-out";
            successGetBar(r.result!.message!);
            getLastAttendance();
          } else {
            if (r.result!.error != null) {
              errorGetBar(r.result!.error!.message ?? "error".tr());
            } else {
              errorGetBar("error".tr());
            }
          }
        } else {
          errorGetBar("error".tr());
        }

        emit(CheckInOutLoaded());
      },
    );
  }

  GetLastAttendanceModel? getLastAttendanceModel;
  getLastAttendance() async {
    emit(GetContractLoading());
    final result = await api.getLastAttendance();
    result.fold(
      (failure) => emit(GetContractError()),
      (r) {
        getLastAttendanceModel = r;

        emit(GetContractLoaded());
      },
    );
  }

}
