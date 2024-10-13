// To parse this JSON data, do
//
//     final createOrderModel = createOrderModelFromJson(jsonString);

import 'dart:convert';

CreateOrderModel createOrderModelFromJson(String str) => CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {
    String? jsonrpc;
    dynamic id;
    Result? result;

    CreateOrderModel({
        this.jsonrpc,
        this.id,
        this.result,
    });

    factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result?.toJson(),
    };
}

class Result {
    int? orderId;
    String? message;

    Result({
        this.orderId,
        this.message,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        orderId: json["order_id"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "message": message,
    };
}
