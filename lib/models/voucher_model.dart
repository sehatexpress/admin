import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../config/extensions.dart';
import '../config/strings.dart';

class VoucherModel {
  final String id;
  final String code;
  final double value;
  final String type;
  final double minimumOrder;
  final String beginDate;
  final String? expiryDate;
  final double upto;
  final String? restaurantId;
  final String? userId;
  final bool status;
  final int? createdAt;
  final int? updatedAt;
  final List<String> users;
  final List<String>? conditions;
  final String? createdBy;
  final String? updatedBy;
  final bool expired;
  final String? city;
  VoucherModel({
    required this.id,
    required this.code,
    required this.value,
    required this.type,
    required this.minimumOrder,
    required this.beginDate,
    this.expiryDate,
    required this.upto,
    this.restaurantId,
    this.userId,
    this.status = true,
    this.createdAt,
    this.updatedAt,
    this.users = const [],
    this.conditions,
    this.createdBy,
    this.updatedBy,
    this.expired = true,
    this.city,
  });

  VoucherModel copyWith({
    String? id,
    String? code,
    double? value,
    String? type,
    double? minimumOrder,
    String? beginDate,
    String? expiryDate,
    double? upto,
    String? restaurantId,
    String? userId,
    bool? status,
    int? createdAt,
    int? updatedAt,
    List<String>? users,
    List<String>? conditions,
    String? createdBy,
    String? updatedBy,
    bool? expired,
    String? city,
  }) =>
      VoucherModel(
        id: id ?? this.id,
        code: code ?? this.code,
        value: value ?? this.value,
        type: type ?? this.type,
        minimumOrder: minimumOrder ?? this.minimumOrder,
        beginDate: beginDate ?? this.beginDate,
        expiryDate: expiryDate ?? this.expiryDate,
        upto: upto ?? this.upto,
        restaurantId: restaurantId ?? this.restaurantId,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        users: users ?? this.users,
        conditions: conditions ?? this.conditions,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        expired: expired ?? this.expired,
        city: city ?? this.city,
      );

  factory VoucherModel.fromSnapshot(DocumentSnapshot snap) => VoucherModel(
        id: snap.id,
        code: snap[Fields.code],
        value: snap[Fields.value].toDouble(),
        type: snap[Fields.type],
        minimumOrder: snap[Fields.minimumOrder].toDouble(),
        beginDate: snap[Fields.beginDate],
        expiryDate: snap[Fields.expiryDate],
        upto: snap[Fields.upto].toDouble(),
        status: snap[Fields.status],
        restaurantId: snap.data().toString().contains(Fields.restaurantId)
            ? snap[Fields.restaurantId]
            : null,
        userId: snap.data().toString().contains(Fields.userId)
            ? snap[Fields.userId]
            : null,
        createdAt: snap[Fields.createdAt],
        updatedAt: snap[Fields.updatedAt],
        users: List<String>.from(snap[Fields.users]),
        conditions: List<String>.from(snap[Fields.conditions]),
        createdBy: snap.data().toString().contains(Fields.createdBy)
            ? snap[Fields.createdBy]
            : null,
        updatedBy: snap.data().toString().contains(Fields.updatedBy)
            ? snap[Fields.updatedBy]
            : null,
        expired: snap[Fields.expiryDate].toString().isVoucherExpired,
        city: snap.data().toString().contains(Fields.city) &&
                snap[Fields.city] != null
            ? snap[Fields.city]
            : null,
      );

  @override
  String toString() =>
      'VoucherModel(id: $id, code: $code, value: $value, type: $type, minimumOrder: $minimumOrder, beginDate: $beginDate, expiryDate: $expiryDate, upto: $upto, restaurantId: $restaurantId, userId: $userId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, users: $users, conditions: $conditions, createdBy: $createdBy, updatedBy: $updatedBy, expired: $expired, city: $city)';

  @override
  bool operator ==(covariant VoucherModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.value == value &&
        other.type == type &&
        other.minimumOrder == minimumOrder &&
        other.beginDate == beginDate &&
        other.expiryDate == expiryDate &&
        other.upto == upto &&
        other.restaurantId == restaurantId &&
        other.userId == userId &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.users, users) &&
        listEquals(other.conditions, conditions) &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy &&
        other.expired == expired &&
        other.city == city;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      code.hashCode ^
      value.hashCode ^
      type.hashCode ^
      minimumOrder.hashCode ^
      beginDate.hashCode ^
      expiryDate.hashCode ^
      upto.hashCode ^
      restaurantId.hashCode ^
      userId.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      users.hashCode ^
      conditions.hashCode ^
      createdBy.hashCode ^
      updatedBy.hashCode ^
      expired.hashCode ^
      city.hashCode;
}
