// To parse this JSON data, do
//
//     final partnerModel = partnerModelFromJson(jsonString);

import 'dart:convert';

PartnerModel partnerModelFromJson(String str) => PartnerModel.fromJson(json.decode(str));

String partnerModelToJson(PartnerModel data) => json.encode(data.toJson());

class PartnerModel {
    int? id;
    dynamic phone;
    dynamic name;
    dynamic image1920;

    PartnerModel({
        this.id,
        this.phone,
        this.name,
        this.image1920,
    });

    factory PartnerModel.fromJson(Map<String, dynamic> json) => PartnerModel(
        id: json["id"],
        phone: json["phone"],
        name: json["name"],
        image1920: json["image_1920"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "name": name,
        "image_1920": image1920,
    };
}
