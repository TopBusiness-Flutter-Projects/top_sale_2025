// To parse this JSON data, do
//
//     final returnOrderModel = returnOrderModelFromJson(jsonString);

import 'dart:convert';

ReturnOrderModel returnOrderModelFromJson(String str) => ReturnOrderModel.fromJson(json.decode(str));

String returnOrderModelToJson(ReturnOrderModel data) => json.encode(data.toJson());

class ReturnOrderModel {
  String? jsonrpc;
  dynamic id;
  Result? result;

  ReturnOrderModel({
    this.jsonrpc,
    this.id,
    this.result,
  });

  factory ReturnOrderModel.fromJson(Map<String, dynamic> json) => ReturnOrderModel(
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
  List<ReturnedOrder>? returnedOrders;

  Result({
    this.returnedOrders,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    returnedOrders: json["returned_orders"] == null ? [] : List<ReturnedOrder>.from(json["returned_orders"]!.map((x) => ReturnedOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "returned_orders": returnedOrders == null ? [] : List<dynamic>.from(returnedOrders!.map((x) => x.toJson())),
  };
}

class ReturnedOrder {
  dynamic returnPickingId;
  dynamic origin;
  dynamic state;
  dynamic dateDone;
  dynamic partnerName;

  ReturnedOrder({
    this.returnPickingId,
    this.origin,
    this.state,
    this.dateDone,
    this.partnerName,
  });

  factory ReturnedOrder.fromJson(Map<String, dynamic> json) => ReturnedOrder(
    returnPickingId: json["return_picking_id"],
    origin: json["origin"],
    state: json["state"],
    dateDone: json["date_done"],
    partnerName: json["partner_name"],
  );

  Map<String, dynamic> toJson() => {
    "return_picking_id": returnPickingId,
    "origin": origin,
    "state": state,
    "date_done": dateDone,
    "partner_name": partnerName,
  };
}
