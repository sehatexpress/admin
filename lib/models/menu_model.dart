import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class MenuModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final String categoryId;
  final double price;
  final String cityId;
  final String locationId;
  final int quantity;
  final int sold;
  final Map<String, String> nutritions;
  final int status;
  final String createdBy;
  final String createdAt;
  final String? updatedBy;
  final String? updatedAt;
  const MenuModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.categoryId,
    required this.price,
    required this.sold,
    required this.cityId,
    required this.locationId,
    required this.quantity,
    required this.nutritions,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  MenuModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? categoryId,
    double? price,
    int? sold,
    String? cityId,
    String? locationId,
    int? quantity,
    Map<String, String>? nutritions,
    int? status,
    String? createdBy,
    String? createdAt,
    String? updatedBy,
    String? updatedAt,
  }) => MenuModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    image: image ?? this.image,
    categoryId: categoryId ?? this.categoryId,
    price: price ?? this.price,
    sold: sold ?? this.sold,
    cityId: cityId ?? this.cityId,
    locationId: locationId ?? this.locationId,
    quantity: quantity ?? this.quantity,
    nutritions: nutritions ?? this.nutritions,
    status: status ?? this.status,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedBy: updatedBy ?? this.updatedBy,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory MenuModel.fromMap(DocumentSnapshot map) => MenuModel(
    id: map.id,
    name: map['name'] as String,
    description: map['description'] as String,
    image: map['image'] as String,
    categoryId: map['categoryId'] as String,
    price: map['price'] as double,
    sold: map['sold'] as int? ?? 0,
    cityId: map['cityId'] as String,
    locationId: map['locationId'] as String,
    quantity: map['quantity'] as int? ?? 0,
    nutritions: map['nutritions'] as Map<String, String>,
    status: map['status'] as int,
    createdBy: map['createdBy'] as String,
    createdAt: map['createdAt'] as String,
    updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
    updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
  );

  @override
  String toString() =>
      'MenuModel(id: $id, name: $name, description: $description, image: $image, categoryId: $categoryId, price: $price, sold: $sold, city: $cityId, location: $locationId, quantity: $quantity, nutrition: $nutritions, status: $status, createdBy: $createdBy, createdAt: $createdAt, updatedBy: $updatedBy, updatedAt: $updatedAt)';

  @override
  bool operator ==(covariant MenuModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.categoryId == categoryId &&
        other.price == price &&
        other.sold == sold &&
        other.cityId == cityId &&
        other.locationId == locationId &&
        other.quantity == quantity &&
        other.nutritions == nutritions &&
        other.status == status &&
        other.createdBy == createdBy &&
        other.createdAt == createdAt &&
        other.updatedBy == updatedBy &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      categoryId.hashCode ^
      price.hashCode ^
      sold.hashCode ^
      cityId.hashCode ^
      locationId.hashCode ^
      quantity.hashCode ^
      nutritions.hashCode ^
      status.hashCode ^
      createdBy.hashCode ^
      createdAt.hashCode ^
      updatedBy.hashCode ^
      updatedAt.hashCode;
}
