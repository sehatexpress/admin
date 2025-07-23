import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/strings.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final bool status;
  final int? createdAt;
  final String? createdBy;
  final int? updatedAt;
  final String? updatedBy;
  final List<String> cities;
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.status = true,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.cities = const [],
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? status,
    int? createdAt,
    int? updatedAt,
    String? createdBy,
    String? updatedBy,
    List<String>? cities,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        cities: cities ?? this.cities,
      );

  factory CategoryModel.fromSnapshot(DocumentSnapshot snap) => CategoryModel(
        id: snap.id,
        name: snap[Fields.name],
        image: snap[Fields.image],
        status: snap[Fields.status],
        createdAt: snap[Fields.createdAt],
        updatedAt: snap[Fields.updatedAt],
        createdBy: snap[Fields.createdBy],
        updatedBy: snap[Fields.updatedBy],
        cities: List<String>.from(snap[Fields.cities]),
      );

  @override
  String toString() =>
      'CategoryModel(id: $id, name: $name, image: $image, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, cities: $cities)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy &&
        other.cities == cities;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      createdBy.hashCode ^
      updatedBy.hashCode ^
      cities.hashCode;
}
