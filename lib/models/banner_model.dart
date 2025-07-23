import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/strings.dart';

class BannerModel {
  final String id;
  final bool? status;
  final String imageUrl;
  final String? restaurantId;
  final String city;
  final int? createdAt;
  final int? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  BannerModel({
    required this.id,
    this.status,
    required this.imageUrl,
    this.restaurantId,
    required this.city,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  BannerModel copyWith({
    String? id,
    bool? status,
    String? imageUrl,
    String? restaurantId,
    String? city,
    int? createdAt,
    int? updatedAt,
    String? createdBy,
    String? updatedBy,
  }) {
    return BannerModel(
      id: id ?? this.id,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      restaurantId: restaurantId ?? this.restaurantId,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snap) => BannerModel(
        id: snap.id,
        status: snap[Fields.status],
        imageUrl: snap[Fields.imageUrl],
        restaurantId: snap.toString().contains(Fields.restaurantId)
            ? snap[Fields.restaurantId]
            : null,
        city: snap[Fields.city],
        createdBy: snap[Fields.createdBy],
        updatedBy: snap[Fields.updatedBy],
        createdAt: snap[Fields.createdAt],
        updatedAt: snap[Fields.updatedAt],
      );

  @override
  String toString() =>
      'BannerImageModel(id: $id, status: $status, imageUrl: $imageUrl, restaurantId: $restaurantId, city: $city, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';

  @override
  bool operator ==(covariant BannerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.status == status &&
        other.imageUrl == imageUrl &&
        other.restaurantId == restaurantId &&
        other.city == city &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      status.hashCode ^
      imageUrl.hashCode ^
      restaurantId.hashCode ^
      city.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      createdBy.hashCode ^
      updatedBy.hashCode;
}
