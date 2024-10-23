import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';
import '../../../core/models/get_contract_model.dart';
import 'attendance_and_departure_state.dart';
enum AttendanceAndDepartureEnum { workContract, attendanceAndDeparture, monthlySalaries, availableHolidays}

class AttendanceAndDepartureCubit extends Cubit<AttendanceAndDepartureState> {
  AttendanceAndDepartureCubit(this.api) : super(AttendanceAndDepartureInitial());
  ServiceApi api;
  TextEditingController searchController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  GlobalKey<FormState> formKey  = GlobalKey<FormState>();
  GetContractModel ? contractDetails;
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
 }
