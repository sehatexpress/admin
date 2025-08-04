import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class CityModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final int status;
  final String createdBy;
  final String createdAt;
  final String? updatedBy;
  final String? updatedAt;
  const CityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  CityModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    int? status,
    String? createdBy,
    String? createdAt,
    String? updatedBy,
    String? updatedAt,
  }) => CityModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    image: image ?? this.image,
    status: status ?? this.status,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedBy: updatedBy ?? this.updatedBy,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory CityModel.fromMap(DocumentSnapshot map) => CityModel(
    id: map.id,
    name: map['name'] as String,
    description: map['description'] as String,
    image: map['image'] as String,
    status: map['status'] as int,
    createdBy: map['createdBy'] as String,
    createdAt: map['createdAt'] as String,
    updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
    updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
  );

  @override
  String toString() =>
      'CityModel(id: $id, name: $name, description: $description, image: $image, status: $status, createdBy: $createdBy, createdAt: $createdAt, updatedBy: $updatedBy, updatedAt: $updatedAt)';

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
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
      status.hashCode ^
      createdBy.hashCode ^
      createdAt.hashCode ^
      updatedBy.hashCode ^
      updatedAt.hashCode;
}
