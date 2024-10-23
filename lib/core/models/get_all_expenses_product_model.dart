// To parse this JSON data, do
//
//     final getAllExpensesProductModel = getAllExpensesProductModelFromJson(jsonString);

import 'dart:convert';

GetAllExpensesProductModel getAllExpensesProductModelFromJson(String str) => GetAllExpensesProductModel.fromJson(json.decode(str));

String getAllExpensesProductModelToJson(GetAllExpensesProductModel data) => json.encode(data.toJson());

class GetAllExpensesProductModel {
    dynamic success;
    List<Product>? products;

    GetAllExpensesProductModel({
        this.success,
        this.products,
    });

    factory GetAllExpensesProductModel.fromJson(Map<String, dynamic> json) => GetAllExpensesProductModel(
        success: json["success"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    };
}

class Product {
    int? id;
    dynamic name;
    dynamic description;
    dynamic image;

    Product({
        this.id,
        this.name,
        this.description,
        this.image,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
    };
}
