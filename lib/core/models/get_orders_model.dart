// To parse this JSON data, do
//
//     final getOrdersModel = getOrdersModelFromJson(jsonString);

import 'dart:convert';

import 'partner_model.dart';

GetOrdersModel getOrdersModelFromJson(String str) =>
    GetOrdersModel.fromJson(json.decode(str));

String getOrdersModelToJson(GetOrdersModel data) => json.encode(data.toJson());

class GetOrdersModel {
  int? count;
  dynamic prev;
  int? current;
  dynamic next;
  int? totalPages;
  List<Result>? result;

  GetOrdersModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory GetOrdersModel.fromJson(Map<String, dynamic> json) => GetOrdersModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "prev": prev,
        "current": current,
        "next": next,
        "total_pages": totalPages,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  int? userId;
  int? partnerId;
  String? displayName;
  String? state;
  String? writeDate;
  int? amountTotal;
  String? invoiceStatus;
  dynamic deliveryStatus;
  PartnerModel? partnerModel;
  Result({
    this.id,
    this.userId,
    this.partnerId,
    this.displayName,
    this.state,
    this.writeDate,
    this.amountTotal,
    this.invoiceStatus,
    this.deliveryStatus,this.partnerModel
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        partnerId: json["partner_id"],
        displayName: json["display_name"],
        state: json["state"],
        writeDate: json["write_date"],
        amountTotal: json["amount_total"],
        invoiceStatus: json["invoice_status"],
        deliveryStatus: json["delivery_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "partner_id": partnerId,
        "display_name": displayName,
        "state": state,
        "write_date": writeDate,
        "amount_total": amountTotal,
        "invoice_status": invoiceStatus,
        "delivery_status": deliveryStatus,
      };
}
