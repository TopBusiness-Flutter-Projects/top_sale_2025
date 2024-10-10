
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:top_sale/core/api/end_points.dart';
import 'package:top_sale/core/error/exceptions.dart';
import 'package:top_sale/core/error/failures.dart';
import 'package:top_sale/core/models/all_products_model.dart';
import 'package:top_sale/core/models/check_employee_model.dart';
import 'package:top_sale/core/models/get_employee_data_model.dart';
import 'package:top_sale/core/models/get_user_data_model.dart';
import 'package:top_sale/core/models/login_model.dart';
import 'package:top_sale/core/preferences/preferences.dart';

import '../api/base_api_consumer.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);
  Future<String> getSessionId(
      {required String phone,
      required String password,
      String? baseUrl,
      String? database}) async {
    try {
      final odoo = OdooClient(baseUrl ?? EndPoints.baseUrl);
      final odoResponse =
          await odoo.authenticate(database ?? EndPoints.db, phone, password);
      final sessionId = odoResponse.id;
      debugPrint("getSessionId = $sessionId");
      await Preferences.instance.setSessionId(sessionId);
      return sessionId;
    } on OdooException catch (e) {
      return "error";
   
    }
  }
  Future<Either<ServerFailure, AuthModel>> login({
      required String phoneOrMail, required String password,String? baseUrl,
      String? database}) async {
    String sessionId =
        await getSessionId(phone: phoneOrMail, password: password,baseUrl:baseUrl,database: database );
    if (sessionId == 'error') {
      return Left(ServerFailure(message: "server_error".tr()));
    } else {
      try {
        final response = await dio.post(
          EndPoints.auth,
          options: Options(
            headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
          ),
          body: {
            "params": {
              'login': phoneOrMail,
              "password": password,
              "db": EndPoints.db
            },
          },
        );
        return Right(AuthModel.fromJson(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
  }
 Future<Either<Failure, CheckEmployeeModel>> checkEmployee(
      {required String employeeId,required String password}) async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.checkEmployee +
            '?query={id,name}&filter=[["barcode","=","$employeeId"],["pin","=","$password"]]',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      return Right(CheckEmployeeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
 
   Future<Either<Failure, GetUserDataModel>> getUserData() async {
    try {
      String userId = await Preferences.instance.getUserId() ?? "1";
      print("lllllllllll${userId}");
      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.getUserData + '$userId?query={id, name,partner_id,image_1920,login}',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      return Right(GetUserDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
   Future<Either<Failure, GetEmployeeDataModel>> getEmployeeData() async {
    try {
      String employeeId = await Preferences.instance.getEmployeeId() ?? "1";
      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.checkEmployee + '$employeeId?query={id, name,image_1920,work_phone,work_email}',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      return Right(GetEmployeeDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

 Future<Either<Failure, AllProductsModel>> getAllProducts(int page) async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();

      final response = await dio.get(
        EndPoints.allProducts +
            '?filter=[["detailed_type","=","product"]]&query={id,name,list_price,taxes_id,uom_name,uom_id,qty_available}&page_size=10&limit=10&page=$page',
        // '?filter=[["detailed_type","=","product"],["virtual_available","!=",0.0]]&query={id,name,categ_id,list_price,currency_id,taxes_id,uom_name,uom_id,description_sale,virtual_available,image_1920}&page_size=10&limit=10&page=$page',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );     
      return Right(AllProductsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, AllProductsModel>> searchProducts(
      int page, String name, bool isBarcode) async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();

      final response = await dio.get(
        isBarcode
            ? EndPoints.allProducts +
                '?filter=[["detailed_type","=","product"],["barcode","=","$name"]]&query={id,name,list_price,taxes_id,uom_name,uom_id,qty_available}&page_size=10&limit=10&page=$page'
            : EndPoints.allProducts +
                '?filter=[["detailed_type","=","product"],["name", "=like", "%$name%"]]&query={id,name,list_price,taxes_id,uom_name,uom_id,qty_available}&page_size=10&limit=10&page=$page',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      return Right(AllProductsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


}
