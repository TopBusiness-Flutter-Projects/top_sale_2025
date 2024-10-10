// To parse this JSON data, do
//
//     final checkEmployeeModel = checkEmployeeModelFromJson(jsonString);

import 'dart:convert';

CheckEmployeeModel checkEmployeeModelFromJson(String str) => CheckEmployeeModel.fromJson(json.decode(str));

String checkEmployeeModelToJson(CheckEmployeeModel data) => json.encode(data.toJson());

class CheckEmployeeModel {
    List<Result>? result;

    CheckEmployeeModel({
        this.result,
    });

    factory CheckEmployeeModel.fromJson(Map<String, dynamic> json) => CheckEmployeeModel(
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    int? id;
    dynamic name;

    Result({
        this.id,
        this.name,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
