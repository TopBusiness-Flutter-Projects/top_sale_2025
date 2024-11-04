// To parse this JSON data, do
//
//     final returnOrderModel = returnOrderModelFromJson(jsonString);

import 'dart:convert';

ReturnOrderModel returnOrderModelFromJson(String str) => ReturnOrderModel.fromJson(json.decode(str));

String returnOrderModelToJson(ReturnOrderModel data) => json.encode(data.toJson());

class ReturnOrderModel {
    Result? result;

    ReturnOrderModel({
        this.result,
    });

    factory ReturnOrderModel.fromJson(Map<String, dynamic> json) => ReturnOrderModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
    };
}

class Result {
    dynamic saleOrderId;
    dynamic returnPickingId;
    dynamic creditNoteId;
    dynamic message;

    Result({
        this.saleOrderId,
        this.returnPickingId,
        this.creditNoteId,
        this.message,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        saleOrderId: json["sale_order_id"],
        returnPickingId: json["return_picking_id"],
        creditNoteId: json["credit_note_id"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "sale_order_id": saleOrderId,
        "return_picking_id": returnPickingId,
        "credit_note_id": creditNoteId,
        "message": message,
    };
}
