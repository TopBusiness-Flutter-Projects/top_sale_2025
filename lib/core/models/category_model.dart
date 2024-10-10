class AllCategoriesModel {
  int? count;
  dynamic prev;
  int? current;
  dynamic next;
  int? totalPages;
  List<CategoriesModelData>? result;

  AllCategoriesModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) =>
      AllCategoriesModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<CategoriesModelData>.from(
                json["result"]!.map((x) => CategoriesModelData.fromJson(x))),
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

class CategoriesModelData {
  String? name;

  int? id;
  String? displayName;

  CategoriesModelData({
    this.name,
    this.id,
    this.displayName,
  });

  factory CategoriesModelData.fromJson(Map<String, dynamic> json) =>
      CategoriesModelData(
        name: json["name"],
        id: json["id"],
        displayName: json["display_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "display_name": displayName,
      };
}
