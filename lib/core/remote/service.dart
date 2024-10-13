// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:top_sale/core/api/end_points.dart';
import 'package:top_sale/core/error/exceptions.dart';
import 'package:top_sale/core/error/failures.dart';
import 'package:top_sale/core/models/all_partners_for_reports_model.dart';
import 'package:top_sale/core/models/all_products_model.dart';
import 'package:top_sale/core/models/category_model.dart';
import 'package:top_sale/core/models/check_employee_model.dart';
import 'package:top_sale/core/models/get_employee_data_model.dart';
import 'package:top_sale/core/models/get_user_data_model.dart';
import 'package:top_sale/core/models/login_model.dart';
import 'package:top_sale/core/preferences/preferences.dart';
import 'package:top_sale/core/utils/app_strings.dart';

import '../api/base_api_consumer.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class ServiceApi {
  final BaseApiConsumer dio;
  ServiceApi(this.dio);
  Future<String> getSessionId(
      {required String phone,
      required String password,
      required String baseUrl,
      required String database}) async {
    try {
      final odoo = OdooClient(baseUrl);
      final odoResponse = await odoo.authenticate(database, phone, password);
      final sessionId = odoResponse.id;
      debugPrint("getSessionId = $sessionId");
      await Preferences.instance.setSessionId(sessionId);
      return sessionId;
    } on OdooException catch (e) {
      return "error";
    }
  }

  Future<Either<ServerFailure, AuthModel>> login(
      {required String phoneOrMail,
      required String password,
      required String baseUrl,
      required String database}) async {
    String sessionId = await getSessionId(
        phone: phoneOrMail,
        password: password,
        baseUrl: baseUrl,
        database: database);
    if (sessionId == 'error') {
      return Left(ServerFailure(message: "server_error".tr()));
    } else {
      try {
        final response = await dio.post(
          baseUrl + EndPoints.auth,
          options: Options(
            headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
          ),
          body: {
            "params": {
              'login': phoneOrMail,
              "password": password,
              "db": database
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
      {required String employeeId, required String password}) async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      String odooUrl =
          await Preferences.instance.getOdooUrl() ?? AppStrings.demoBaseUrl;
      final response = await dio.get(
        odooUrl +
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
      String odooUrl =
          await Preferences.instance.getOdooUrl() ?? AppStrings.demoBaseUrl;

      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        odooUrl +
            EndPoints.getUserData +
            '$userId?query={id, name,partner_id,image_1920,login}',
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
      String odooUrl =
          await Preferences.instance.getOdooUrl() ?? AppStrings.demoBaseUrl;

      final response = await dio.get(
        odooUrl +
            EndPoints.checkEmployee +
            '$employeeId?query={id, name,image_1920,work_phone,work_email}',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      return Right(GetEmployeeDataModel.fromJson(response));
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
                '?filter=[["detailed_type","=","product"],["barcode","=","$name"]]&query={id,name,list_price,taxes_id,uom_name,uom_id,qty_available,categ_id}&page_size=10&limit=10&page=$page'
            : EndPoints.allProducts +
                '?filter=[["detailed_type","=","product"],["name", "=like", "%$name%"]]&query={id,name,list_price,taxes_id,uom_name,uom_id,qty_available,categ_id}&page_size=10&limit=10&page=$page',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      return Right(AllProductsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetCategoriesModel>> getAllCategories() async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      String odooUrl =
          await Preferences.instance.getOdooUrl() ?? AppStrings.demoBaseUrl;

      final response = await dio.get(
        odooUrl + EndPoints.allCategoriesUrl,
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );

      return Right(GetCategoriesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
//getAllProducts
  Future<Either<Failure, AllProductsModel>> getAllProducts(int page) async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      String odooUrl =
          await Preferences.instance.getOdooUrl() ?? AppStrings.demoBaseUrl;
      final response = await dio.get(
        odooUrl +
            EndPoints.allProducts +
            '?filter=[["detailed_type","=","product"]]&query={id,name,list_price,taxes_id,uom_name,uom_id,qty_available,categ_id}&page_size=10&limit=10&page=$page',
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

  Future<Either<Failure, AllProductsModel>> getAllProductsByCategory(int page,
      {required int categoryId}) async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      String odooUrl =
          await Preferences.instance.getOdooUrl() ?? AppStrings.demoBaseUrl;
      final response = await dio.get(
        odooUrl +
            EndPoints.allProducts +
            '?filter=[["detailed_type","=","product"],["categ_id", "=", [$categoryId]]&query={id,name,list_price,taxes_id,uom_name,uom_id,qty_available,categ_id}&page_size=10&limit=10&page=$page',
        // '?filter=[["detailed_type","=","product"],["virtual_available","!=",0.0]]&query={id,name,categ_id,list_price,currency_id,taxes_id,uom_name,uom_id,description_sale,virtual_available,image_1920}&page_size=10&limit=10&page=$page',

        // queryParameters: {
        //   'filter': '[["categ_id", "=", [$categoryId]]',
        //   'query':
        //       '{id,name,list_price,taxes_id,uom_name,uom_id,virtual_available,categ_id}'
        // },
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );

      return Right(AllProductsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetAllPartnersModel>> getAllPartnersForReport(
      int page, int pageSize) async {
    try {
      String odooUrl =
          await Preferences.instance.getOdooUrl() ?? AppStrings.demoBaseUrl;
      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        odooUrl +
            EndPoints.getAllPartners +
            '?page_size=$pageSize&page=$page&query={name,id,phone,total_overdue,total_due,total_invoiced,credit_to_invoice,sale_order_ids}',
        // 'page_size=$pageSize&page=$page&filter=[["user_id", "=",${authModel.result!.userContext!.uid}]]&query={name,id,phone,total_overdue,total_due,total_invoiced,credit_to_invoice,sale_order_ids}',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      return Right(GetAllPartnersModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetAllPartnersModel>> searchUsers(
      int page, String name) async {
    try {
      String odooUrl =
          await Preferences.instance.getOdooUrl() ?? AppStrings.demoBaseUrl;
      String? sessionId = await Preferences.instance.getSessionId();

      final response = await dio.get(
        odooUrl +
            EndPoints.getAllPartners +
            '?filter=[["name", "=like", "%$name%"]]&query={name,id,phone,total_overdue,total_due,total_invoiced,credit_to_invoice,sale_order_ids}&page_size=20&page=$page',
        // 'filter=[["name", "=like", "%$name%"],["user_id", "=",${authModel.result!.userContext!.uid}]]&query={name,id,phone,total_overdue,total_due,total_invoiced,credit_to_invoice,sale_order_ids}&page_size=20&page=$page',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      print("lllllllllllll" + response.toString());
      return Right(GetAllPartnersModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
