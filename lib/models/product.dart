import 'dart:convert';

// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  List<Product> data;
  int status;
  String message;

  ProductResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Product {
  String id;
  String title;
  int price;
  Category category;
  String? description;
  CreatedBy createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  String slug;
  String? image;
  bool isFavorite;
  bool isInCart;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    this.image,
    this.isFavorite = false,
    this.isInCart = false,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        title: json["title"],
        price: json["price"],
        category: Category.fromJson(json["category"]),
        description: json["description"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        slug: json["slug"],
        image: json["image"],
        isFavorite: json["isFavorite"] ?? false,
        isInCart: json["isInCart"] ?? false,
        quantity: json["quantity"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "price": price,
        "category": category.toJson(),
        "description": description,
        "createdBy": createdBy.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "slug": slug,
        "image": image,
        "isFavorite": isFavorite,
        "isInCart": isInCart,
        "quantity": quantity,
      };

  Product copyWith({
    String? id,
    String? title,
    int? price,
    Category? category,
    String? description,
    CreatedBy? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? slug,
    String? image,
    bool? isFavorite,
    bool? isInCart,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
      isInCart: isInCart ?? this.isInCart,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Category {
  String id;
  String name;
  String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
      };
}

class CreatedBy {
  Role? role;
  String id;
  String name;

  CreatedBy({
    required this.role,
    required this.id,
    required this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        role: roleValues.map[json["role"]],
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "role": roleValues.reverse[role],
        "_id": id,
        "name": name,
      };
}

enum Role {
  // ignore: constant_identifier_names
  ROLE_CUSTOMER
}

final roleValues = EnumValues({
  "ROLE_CUSTOMER": Role.ROLE_CUSTOMER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap;
  }
}