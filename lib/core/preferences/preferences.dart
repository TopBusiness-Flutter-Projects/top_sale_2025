import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;

  // Future<void> setFirstInstall() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('onBoarding', 'Done');
  // }

  // Future<String?> getFirstInstall() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? jsonData = prefs.getString('onBoarding');
  //   return jsonData;
  // }

  // Future<void> setUser(LoginModel loginModel) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString(
  //       'user', jsonEncode(LoginModel.fromJson(loginModel.toJson())));
  //   print(await getUserModel());
  // }

  Future<void> clearShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  // Future<LoginModel> getUserModel() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? jsonData = preferences.getString('user');
  //   LoginModel userModel;
  //   if (jsonData != null) {
  //     userModel = LoginModel.fromJson(jsonDecode(jsonData));
  //   } else {
  //     userModel = LoginModel();
  //   }
  //   return userModel;
  // }


  Future<void> setSessionId(String sessionId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('sessionId', sessionId);
    print("sessionId = $sessionId");
  }

  Future<String?> getSessionId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? sessionId = preferences.getString('sessionId');
    return sessionId;
  }
Future<void> setDataBaseName(String db) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('database', db);
    print("sessionIdTrueUser = $db");
  }
  
  Future<String?> getDataBaseName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? database = preferences.getString('database');
    return database;
  }
Future<void> setOdooUrl(String url) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('odooUrl', url);
    print("sessionIdTrueUser = $url");
  }
  
  Future<String?> getOdooUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? url = preferences.getString('odooUrl');
    return url;
  }

  Future<void> setUserId(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userId', userId);
    print("userId = $userId");
  }


  Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    return userId;
  }
  Future<void> setCompanyId(String companyId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('companyId', companyId);
    print("userId = $companyId");
  }


  Future<String?> getCompanyId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? companyId = preferences.getString('companyId');
    return companyId;
  }

  Future<void> setUserName(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userName', userName);
   
  }

  Future<void> removeUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('userName');
  }

  Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userName = preferences.getString('userName');
    return userName;
  }

  Future<void> setUserPass(String userPass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userPass', userPass);
    print("Password = $userPass");
  }

  Future<String?> getUserPass() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userPass = preferences.getString('userPass');
    return userPass;
  }


  Future<void> setEmployeeId(String employeeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('employeeId', employeeId);
    print("employeeId = $employeeId");
  }
  Future<void> removeEmployeeId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('employeeId');
  }

  Future<String?> getEmployeeId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? employeeId = preferences.getString('employeeId');
    return employeeId;
  }
}
