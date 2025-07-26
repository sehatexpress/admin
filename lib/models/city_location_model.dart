import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class CityLocationModel {
  final String id;
  final String name;
  final String cityId;
  final double deliveryCharge;
  final bool status;
  final String createdBy;
  final String createdAt;
  final String? updatedBy;
  final String? updatedAt;
  const CityLocationModel({
    required this.id,
    required this.name,
    required this.cityId,
    required this.deliveryCharge,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  CityLocationModel copyWith({
    String? id,
    String? name,
    String? cityId,
    double? deliveryCharge,
    bool? status,
    String? createdBy,
    String? createdAt,
    String? updatedBy,
    String? updatedAt,
  }) => CityLocationModel(
    id: id ?? this.id,
    name: name ?? this.name,
    cityId: cityId ?? this.cityId,
    deliveryCharge: deliveryCharge ?? this.deliveryCharge,
    status: status ?? this.status,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedBy: updatedBy ?? this.updatedBy,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory CityLocationModel.fromMap(DocumentSnapshot map) =>
      CityLocationModel(
        id: map.id,
        name: map['name'] as String,
        cityId: map['cityId'] as String,
        deliveryCharge: map['deliveryCharge'] as double,
        status: map['status'] as bool,
        createdBy: map['createdBy'] as String,
        createdAt: map['createdAt'] as String,
        updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
        updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      );

  @override
  String toString() =>
      'CityLocationModel(id: $id, name: $name, cityId: $cityId, deliveryCharge: $deliveryCharge, status: $status, createdBy: $createdBy, createdAt: $createdAt, updatedBy: $updatedBy, updatedAt: $updatedAt)';

  @override
  bool operator ==(covariant CityLocationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.cityId == cityId &&
        other.deliveryCharge == deliveryCharge &&
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
      cityId.hashCode ^
      deliveryCharge.hashCode ^
      status.hashCode ^
      createdBy.hashCode ^
      createdAt.hashCode ^
      updatedBy.hashCode ^
      updatedAt.hashCode;
}
