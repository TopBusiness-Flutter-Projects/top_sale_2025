// To parse this JSON data, do
//
//     final allPaymentsModel = allPaymentsModelFromJson(jsonString);

import 'dart:convert';

AllPaymentsModel allPaymentsModelFromJson(String str) => AllPaymentsModel.fromJson(json.decode(str));

String allPaymentsModelToJson(AllPaymentsModel data) => json.encode(data.toJson());

class AllPaymentsModel {
    dynamic count;
    dynamic prev;
    dynamic current;
    dynamic next;
    dynamic totalPages;
    List<PaymentResult>? result;

    AllPaymentsModel({
        this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result,
    });

    factory AllPaymentsModel.fromJson(Map<String, dynamic> json) => AllPaymentsModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null ? [] : List<PaymentResult>.from(json["result"]!.map((x) => PaymentResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "prev": prev,
        "current": current,
        "next": next,
        "total_pages": totalPages,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class PaymentResult {
    int? id;
    PartnerId? partnerId;

    PaymentResult({
        this.id,
        this.partnerId,
    });

    factory PaymentResult.fromJson(Map<String, dynamic> json) => PaymentResult(
        id: json["id"],
        partnerId: json["partner_id"] == null ? null : PartnerId.fromJson(json["partner_id"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "partner_id": partnerId?.toJson(),
    };
}

class PartnerId {
    dynamic name;
    dynamic id;
    dynamic image1920;
    dynamic phone;

    PartnerId({
        this.name,
        this.id,
        this.image1920,
        this.phone,
    });

    factory PartnerId.fromJson(Map<String, dynamic> json) => PartnerId(
        name: json["name"],
        id: json["id"],
        image1920: json["image_1920"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "image_1920": image1920,
        "phone": phone,
    };
}
