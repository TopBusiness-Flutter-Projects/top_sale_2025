import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/models/get_last_attendance_model.dart';
import 'package:top_sale/core/remote/service.dart';
import 'package:top_sale/core/utils/appwidget.dart';
import 'package:top_sale/core/utils/dialogs.dart';
import '../../../core/models/get_contract_model.dart';
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
