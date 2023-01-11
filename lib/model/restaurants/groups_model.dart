class ProductGroups {
  ProductGroups({
    this.id,
    this.name,
    this.type,
    this.items,
  });

  int? id;
  String? name;
  String? type;
  List<ProductItems>? items;

  factory ProductGroups.fromJson(Map<String, dynamic> json) => ProductGroups(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        items: List<ProductItems>.from(json["items"].map((x) => ProductItems.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "items": List<ProductItems>.from(items!.map((x) => x.toJson())),
      };
}

class ProductItems {
  ProductItems({
    this.id,
    this.name,
    this.price,
  });

  int? id;
  String? name;
  double? price;

  factory ProductItems.fromJson(Map<String, dynamic> json) => ProductItems(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        price: double.parse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
