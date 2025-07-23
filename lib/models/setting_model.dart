import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/strings.dart';

class SettingModel {
  final String id;
  final double baseDeliveryCharge;
  final int baseDeliveryKM;
  final int radiusKM;
  final double perKM;
  final int freeDelivery;
  final int freeDeliveryKM;
  final double minimumOrder;
  final String? createdBy;
  final int? createdAt;
  final String? updatedBy;
  final int? updatedAt;
  SettingModel({
    required this.id,
    required this.baseDeliveryCharge,
    required this.baseDeliveryKM,
    required this.radiusKM,
    required this.perKM,
    required this.freeDelivery,
    required this.freeDeliveryKM,
    required this.minimumOrder,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  SettingModel copyWith({
    String? id,
    double? baseDeliveryCharge,
    int? baseDeliveryKM,
    int? radiusKM,
    double? perKM,
    int? freeDelivery,
    int? freeDeliveryKM,
    double? minimumOrder,
    String? createdBy,
    int? createdAt,
    String? updatedBy,
    int? updatedAt,
  }) =>
      SettingModel(
        id: id ?? this.id,
        baseDeliveryCharge: baseDeliveryCharge ?? this.baseDeliveryCharge,
        baseDeliveryKM: baseDeliveryKM ?? this.baseDeliveryKM,
        radiusKM: radiusKM ?? this.radiusKM,
        perKM: perKM ?? this.perKM,
        freeDelivery: freeDelivery ?? this.freeDelivery,
        freeDeliveryKM: freeDeliveryKM ?? this.freeDeliveryKM,
        minimumOrder: minimumOrder ?? this.minimumOrder,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory SettingModel.fromSnapshot(DocumentSnapshot map) => SettingModel(
        id: map.id,
        baseDeliveryCharge: map[Fields.baseDeliveryCharge],
        baseDeliveryKM: map[Fields.baseDeliveryKM],
        radiusKM: map[Fields.radiusKM],
        perKM: map[Fields.perKM],
        freeDelivery: map[Fields.freeDelivery],
        freeDeliveryKM: map[Fields.freeDeliveryKM],
        minimumOrder: map[Fields.minimumOrder],
        createdBy: map[Fields.createdBy],
        createdAt: map[Fields.createdAt],
        updatedBy: map[Fields.updatedBy],
        updatedAt: map[Fields.updatedAt],
      );

  @override
  String toString() =>
      'SettingModel(id: $id, deliveryCharge: $baseDeliveryCharge, radiusKM: $radiusKM, freeDelivery: $freeDelivery, freeDeliveryKM: $freeDeliveryKM, perKM: $perKM, minimumOrder: $minimumOrder, createdBy: $createdBy, createdAt: $createdAt, updatedBy: $updatedBy, updatedAt: $updatedAt)';

  @override
  bool operator ==(covariant SettingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.baseDeliveryCharge == baseDeliveryCharge &&
        other.radiusKM == radiusKM &&
        other.perKM == perKM &&
        other.freeDelivery == freeDelivery &&
        other.freeDeliveryKM == freeDeliveryKM &&
        other.minimumOrder == minimumOrder &&
        other.createdBy == createdBy &&
        other.createdAt == createdAt &&
        other.updatedBy == updatedBy &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      baseDeliveryCharge.hashCode ^
      radiusKM.hashCode ^
      perKM.hashCode ^
      freeDelivery.hashCode ^
      freeDeliveryKM.hashCode ^
      minimumOrder.hashCode ^
      createdBy.hashCode ^
      createdAt.hashCode ^
      updatedBy.hashCode ^
      updatedAt.hashCode;
}
