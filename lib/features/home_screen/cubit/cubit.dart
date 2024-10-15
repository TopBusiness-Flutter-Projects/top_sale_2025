import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';

import '../../../core/models/get_employee_data_model.dart';
import '../../../core/models/get_user_data_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../profile/cubit/profile_cubit.dart';
import 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(MainInitial()){
    checkEmployeeOrUser();
  }  ServiceApi api;
  String?nameOfUser;
  String?phoneOfUser;
  String? imageOfUser;
  String? emailOfUser;
  GetUserDataModel ?getUserDataModel;
  //get  userdata
  void getUserData() async {
    emit(ProfileUserLoading());
    final result = await api.getUserData();
    result.fold(
          (failure) =>
          emit(ProfileUserLoaded(error: 'Error loading data: $failure')),
          (r) {
        getUserDataModel = r;
        nameOfUser = r.name;
        if(r.phone=='false'){
          phoneOfUser = "";
          debugPrint("phone false of user");

        }else{
          phoneOfUser = r.phone;
        }
        imageOfUser = r.image1920;
        emailOfUser = r.email;
        emit(ProfileUserError());
      },
    );
  }
//get empolyee data
  GetEmployeeDataModel?getEmployeeDataModel;
  void getEmployeeData() async {
    emit(ProfileEmployeeLoading());
    final result = await api.getEmployeeData();
    result.fold(
          (failure) =>
          emit(ProfileEmployeeError(error: 'Error loading data: $failure')),
          (r) {
        getEmployeeDataModel = r;
        nameOfUser = r.name;
        if(r.workPhone.toString()=='false'){
          debugPrint("phone false of employee");
          phoneOfUser = "";
        }else{
          phoneOfUser = r.workPhone.toString();

        }
        imageOfUser = r.image1920;
        emailOfUser = r.workEmail;

        debugPrint("the model : emmm ${getEmployeeDataModel?.name.toString()}");
        emit(ProfileEmployeeLoaded());
      },
    );
  }
  void checkEmployeeOrUser(){
    Preferences.instance.getEmployeeId().then((value){
      debugPrint('${value.toString()}');
      if(value==null){
        getUserData();
        debugPrint("user");
        // name= getUserDataModel?.name.toString()??"";
      }
      else{
        debugPrint("employee");
        getEmployeeData();
        // name= getEmployeeDataModel?.name.toString()??"";
      }
      emit(checkLoaded());

    });
emit(checkLoaded());
  }
}
