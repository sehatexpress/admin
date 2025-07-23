import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../config/enums.dart';
import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/position_model.dart';

class DeliveryPartnerModel {
  final String uid;
  final String name;
  final String email;
  final int gender;
  final String mobile;
  final String address;
  final String city;
  final String? imageUrl;
  final PositionModel? position;
  final int? points;
  final bool? status;
  final int? totalDelivery;
  final double? balance;
  final int? createdAt;
  final int? updatedAt;
  final VerificationStatusEnum verificationStatus;
  final double? averageRating;
  final double? totalRating;
  final int? totalUsers;
  final List<String>? likes;
  final String? deviceToken;
  final bool? activeStatus;
  final int? lastActive;
  final String? createdBy;
  final String? updatedBy;
  DeliveryPartnerModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.gender,
    required this.mobile,
    required this.address,
    required this.city,
    this.imageUrl,
    this.position,
    this.points,
    this.status,
    this.totalDelivery,
    this.balance,
    this.createdAt,
    this.updatedAt,
    this.verificationStatus = VerificationStatusEnum.pending,
    this.averageRating,
    this.totalRating,
    this.totalUsers,
    this.likes,
    this.deviceToken,
    this.activeStatus,
    this.lastActive,
    this.createdBy,
    this.updatedBy,
  });

  DeliveryPartnerModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? gender,
    String? mobile,
    String? address,
    String? city,
    String? imageUrl,
    PositionModel? position,
    int? points,
    bool? status,
    int? totalDelivery,
    double? balance,
    int? createdAt,
    int? updatedAt,
    VerificationStatusEnum? verificationStatus,
    double? averageRating,
    double? totalRating,
    int? totalUsers,
    List<String>? likes,
    String? deviceToken,
    bool? activeStatus,
    int? lastActive,
    String? createdBy,
    String? updatedBy,
  }) =>
      DeliveryPartnerModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        mobile: mobile ?? this.mobile,
        address: address ?? this.address,
        city: city ?? this.city,
        imageUrl: imageUrl ?? this.imageUrl,
        position: position ?? this.position,
        points: points ?? this.points,
        status: status ?? this.status,
        totalDelivery: totalDelivery ?? this.totalDelivery,
        balance: balance ?? this.balance,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        averageRating: averageRating ?? this.averageRating,
        totalRating: totalRating ?? this.totalRating,
        totalUsers: totalUsers ?? this.totalUsers,
        likes: likes ?? this.likes,
        deviceToken: deviceToken ?? this.deviceToken,
        activeStatus: activeStatus ?? this.activeStatus,
        lastActive: lastActive ?? this.lastActive,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory DeliveryPartnerModel.fromSnapshot(DocumentSnapshot snap) =>
      DeliveryPartnerModel(
        uid: snap.id,
        name: snap[Fields.name],
        gender: snap[Fields.gender],
        email: snap[Fields.email],
        mobile: snap[Fields.mobile],
        address: snap[Fields.address],
        city: snap.data().toString().contains(Fields.city)
            ? snap[Fields.city]
            : 'birgunj',
        imageUrl: snap[Fields.imageUrl],
        position: snap[Fields.position] != null
            ? PositionModel.fromSnapshot(snap[Fields.position])
            : null,
        points: snap[Fields.points],
        status: snap[Fields.status],
        totalDelivery: snap[Fields.totalDelivery],
        balance: snap[Fields.balance].toDouble(),
        createdAt: snap[Fields.createdAt],
        updatedAt: snap[Fields.updatedAt],
        verificationStatus:
            VerificationStatusEnumX.fromString(snap[Fields.verificationStatus]),
        averageRating: snap[Fields.averageRating].toDouble(),
        totalRating: snap[Fields.totalRating].toDouble(),
        totalUsers: snap[Fields.totalUsers],
        likes: List<String>.from(snap[Fields.likes]),
        deviceToken: snap[Fields.deviceToken],
        activeStatus: snap[Fields.activeStatus],
        lastActive: snap[Fields.lastActive],
        createdBy: snap.data().toString().contains(Fields.createdBy)
            ? snap[Fields.createdBy]
            : null,
        updatedBy: snap.data().toString().contains(Fields.updatedBy)
            ? snap[Fields.updatedBy]
            : null,
      );

  @override
  String toString() =>
      'DeliveryPartnerModel(uid: $uid, name: $name, email: $email, gender: $gender, mobile: $mobile, address: $address, city: $city, imageUrl: $imageUrl, position: $position, points: $points, status: $status, totalDelivery: $totalDelivery, balance: $balance, createdAt: $createdAt, updatedAt: $updatedAt, verificationStatus: $verificationStatus, averageRating: $averageRating, totalRating: $totalRating, totalUsers: $totalUsers, likes: $likes, deviceToken: $deviceToken, activeStatus: $activeStatus, lastActive: $lastActive, createdBy: $createdBy, updatedBy: $updatedBy)';

  @override
  bool operator ==(covariant DeliveryPartnerModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.gender == gender &&
        other.mobile == mobile &&
        other.address == address &&
        other.city == city &&
        other.imageUrl == imageUrl &&
        other.position == position &&
        other.points == points &&
        other.status == status &&
        other.totalDelivery == totalDelivery &&
        other.balance == balance &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.verificationStatus == verificationStatus &&
        other.averageRating == averageRating &&
        other.totalRating == totalRating &&
        other.totalUsers == totalUsers &&
        listEquals(other.likes, likes) &&
        other.deviceToken == deviceToken &&
        other.activeStatus == activeStatus &&
        other.lastActive == lastActive &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      mobile.hashCode ^
      address.hashCode ^
      city.hashCode ^
      imageUrl.hashCode ^
      position.hashCode ^
      points.hashCode ^
      status.hashCode ^
      totalDelivery.hashCode ^
      balance.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      verificationStatus.hashCode ^
      averageRating.hashCode ^
      totalRating.hashCode ^
      totalUsers.hashCode ^
      likes.hashCode ^
      deviceToken.hashCode ^
      activeStatus.hashCode ^
      lastActive.hashCode ^
      createdBy.hashCode ^
      updatedBy.hashCode;
}
