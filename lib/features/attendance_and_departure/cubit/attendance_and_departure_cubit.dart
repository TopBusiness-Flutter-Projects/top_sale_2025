import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';
import 'attendance_and_departure_state.dart';
enum AttendanceAndDepartureEnum { workContract, attendanceAndDeparture, monthlySalaries, availableHolidays}

class AttendanceAndDepartureCubit extends Cubit<AttendanceAndDepartureState> {
  AttendanceAndDepartureCubit(this.api) : super(AttendanceAndDepartureInitial());
  ServiceApi api;
  TextEditingController searchController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  GlobalKey<FormState> formKey  = GlobalKey<FormState>();
 }
