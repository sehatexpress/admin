import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/enums.dart';
import '../config/extensions.dart';

class AdminModel {
  final String uid;
  final String name;
  final String email;
  final String mobile;
  final RoleEnum role;
  final String city;
  final bool? status;
  final int? createdAt;
  final String? createdBy;
  final int? updatedAt;
  final String? updatedBy;
  final String? deviceToken;

  AdminModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
    required this.city,
    this.status = true,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deviceToken,
  });

  AdminModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? mobile,
    RoleEnum? role,
    String? city,
    bool? status,
    int? createdAt,
    String? createdBy,
    int? updatedAt,
    String? updatedBy,
    String? deviceToken,
  }) =>
      AdminModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        role: role ?? this.role,
        city: city ?? this.city,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
        deviceToken: deviceToken ?? this.deviceToken,
      );

  factory AdminModel.fromSnapshot(DocumentSnapshot snap) => AdminModel(
        uid: snap.id,
        name: snap['name'],
        email: snap['email'],
        mobile: snap['mobile'],
        role: RoleEnumX.fromString(snap['role']),
        city: snap['city'],
        status: snap['status'],
        createdAt: snap['createdAt'],
        createdBy: snap['createdBy'],
        updatedAt: snap['updatedAt'],
        updatedBy: snap['updatedBy'],
        deviceToken: snap['deviceToken'],
      );

  @override
  String toString() =>
      'AdminModel(uid: $uid, name: $name, email: $email, mobile: $mobile, role: $role, city: $city, status: $status, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy, deviceToken: $deviceToken)';

  @override
  bool operator ==(covariant AdminModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.mobile == mobile &&
        other.role == role &&
        other.city == city &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.createdBy == createdBy &&
        other.updatedAt == updatedAt &&
        other.updatedBy == updatedBy &&
        other.deviceToken == deviceToken;
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      mobile.hashCode ^
      role.hashCode ^
      city.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      createdBy.hashCode ^
      updatedAt.hashCode ^
      updatedBy.hashCode ^
      deviceToken.hashCode;
}
