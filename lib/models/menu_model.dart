import 'package:flutter/foundation.dart';

import 'nutrition_model.dart';

@immutable
class MenuModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final String categoryId;
  final double price;
  final String city;
  final String location;
  final NutritionModel nutritions;
  final bool status;
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
    required this.city,
    required this.location,
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
    String? city,
    String? location,
    NutritionModel? nutritions,
    bool? status,
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
    city: city ?? this.city,
    location: location ?? this.location,
    nutritions: nutritions ?? this.nutritions,
    status: status ?? this.status,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedBy: updatedBy ?? this.updatedBy,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory MenuModel.fromMap(Map<String, dynamic> map) => MenuModel(
    id: map['id'] as String,
    name: map['name'] as String,
    description: map['description'] as String,
    image: map['image'] as String,
    categoryId: map['categoryId'] as String,
    price: map['price'] as double,
    city: map['city'] as String,
    location: map['location'] as String,
    nutritions: NutritionModel.fromMap(map['nutritions'] as Map<String, dynamic>),
    status: map['status'] as bool,
    createdBy: map['createdBy'] as String,
    createdAt: map['createdAt'] as String,
    updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
    updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
  );

  @override
  String toString() =>
      'MenuModel(id: $id, name: $name, description: $description, image: $image, categoryId: $categoryId, price: $price, city: $city, location: $location, nutrition: $nutritions, status: $status, createdBy: $createdBy, createdAt: $createdAt, updatedBy: $updatedBy, updatedAt: $updatedAt)';

  @override
  bool operator ==(covariant MenuModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.categoryId == categoryId &&
        other.price == price &&
        other.city == city &&
        other.location == location &&
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
      city.hashCode ^
      location.hashCode ^
      nutritions.hashCode ^
      status.hashCode ^
      createdBy.hashCode ^
      createdAt.hashCode ^
      updatedBy.hashCode ^
      updatedAt.hashCode;
}
