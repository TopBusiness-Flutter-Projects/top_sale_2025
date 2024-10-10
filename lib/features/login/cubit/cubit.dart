import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';

import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginStateInitial());
  ServiceApi api;
  TextEditingController companynameController = TextEditingController();
  TextEditingController odooLinkController = TextEditingController();
  TextEditingController dbNumberController = TextEditingController();
  TextEditingController adminNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();
//! case user
  TextEditingController usernameController = TextEditingController();
  //! case emplyee
  TextEditingController emplyeeNumberController = TextEditingController();

  bool isEmplyee = false;
  onchangeEmplyeeStatus(bool status) {
    isEmplyee = status;
    emplyeeNumberController.clear();
    usernameController.clear();

    emit(ChnageStatusOfEmplyeeAndUser());
  }
}
