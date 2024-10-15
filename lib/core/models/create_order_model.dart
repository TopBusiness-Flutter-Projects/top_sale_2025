// To parse this JSON data, do
//
//     final createOrderModel = createOrderModelFromJson(jsonString);

import 'dart:convert';

CreateOrderModel createOrderModelFromJson(String str) => CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {

    Result? result;

    CreateOrderModel({

        this.result,
    });

    factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(

        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {

        "result": result?.toJson(),
    };
}

class Result {
   
    String? message;

    Result({
       
        this.message,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
       
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
       
        "message": message,
    };
}
