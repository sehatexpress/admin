import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../config/enums.dart';
import '../config/extensions.dart';
import '../config/strings.dart';

@immutable
class ProductModel {
  final String id;
  final String restaurantId;
  final String name;
  final MenuTypeEnum type;
  final String category;
  final String? image;
  final double price;
  final double sellingPrice;
  final CommissionTypeEnum commissionType;
  final double commission;
  final bool featured;
  final bool newProduct;
  final bool recommended;
  final bool bestSeller;
  final double? averageRating;
  final double? totalRating;
  final int? totalUsers;
  final List<dynamic>? likes;
  final int? sold;
  final bool? status;
  final int? createdAt;
  final int? updatedAt;
  final String? description;
  final String? createdBy;
  final String? updatedBy;
  const ProductModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.type,
    required this.category,
    this.image,
    required this.price,
    required this.sellingPrice,
    required this.commissionType,
    required this.commission,
    required this.featured,
    required this.newProduct,
    required this.recommended,
    required this.bestSeller,
    this.averageRating,
    this.totalRating,
    this.totalUsers,
    this.likes,
    this.sold,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.createdBy,
    this.updatedBy,
  });

  ProductModel copyWith({
    String? id,
    String? restaurantId,
    String? name,
    MenuTypeEnum? type,
    String? category,
    String? image,
    double? price,
    double? sellingPrice,
    CommissionTypeEnum? commissionType,
    double? commission,
    bool? featured,
    bool? newProduct,
    bool? recommended,
    bool? bestSeller,
    double? averageRating,
    double? totalRating,
    int? totalUsers,
    List<dynamic>? likes,
    int? sold,
    bool? status,
    int? createdAt,
    int? updatedAt,
    String? description,
    String? createdBy,
    String? updatedBy,
  }) =>
      ProductModel(
        id: id ?? this.id,
        restaurantId: restaurantId ?? this.restaurantId,
        name: name ?? this.name,
        type: type ?? this.type,
        category: category ?? this.category,
        image: image ?? this.image,
        price: price ?? this.price,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        commissionType: commissionType ?? this.commissionType,
        commission: commission ?? this.commission,
        featured: featured ?? this.featured,
        newProduct: newProduct ?? this.newProduct,
        recommended: recommended ?? this.recommended,
        bestSeller: bestSeller ?? this.bestSeller,
        averageRating: averageRating ?? this.averageRating,
        totalRating: totalRating ?? this.totalRating,
        totalUsers: totalUsers ?? this.totalUsers,
        likes: likes ?? this.likes,
        sold: sold ?? this.sold,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        description: description ?? this.description,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  // Map<String, dynamic> toDocument() => {
  //       'restaurantId': restaurantId,
  //       'name': name.toLowerCase(),
  //       'type': type.value,
  //       'category': category.toLowerCase(),
  //       'image': image,
  //       'price': price,
  //       'sellingPrice': sellingPrice,
  //       'commissionType': commissionType.value,
  //       'commission': commission,
  //       'featured': featured,
  //       'newProduct': newProduct,
  //       'recommended': recommended,
  //       'bestSeller': bestSeller,
  //       'averageRating': 0,
  //       'totalRating': 0,
  //       'totalUsers': 0,
  //       'likes': const [],
  //       'sold': 0,
  //       'status': true,
  //       'description': description,
  //       'createdAt': DateTime.now().millisecondsSinceEpoch,
  //       'createdBy': authService.user!.uid,
  //       'updatedAt': updatedAt,
  //       'updatedBy': updatedBy,
  //     };

  // Map<String, dynamic> toDocumentUpdate() => {
  //       'restaurantId': restaurantId,
  //       'name': name.toLowerCase(),
  //       'type': type.value.toLowerCase(),
  //       'category': category.toLowerCase(),
  //       'price': price,
  //       'sellingPrice': sellingPrice,
  //       'commissionType': commissionType.value,
  //       'commission': commission,
  //       'featured': featured,
  //       'newProduct': newProduct,
  //       'recommended': recommended,
  //       'bestSeller': bestSeller,
  //       'description': description,
  //       'updatedAt': DateTime.now().millisecondsSinceEpoch,
  //       'updatedBy': authService.user!.uid,
  //     };

  factory ProductModel.fromSnapshot(DocumentSnapshot snap) => ProductModel(
        id: snap.id,
        restaurantId: snap[Fields.restaurantId],
        name: snap[Fields.name],
        type: MenuTypeX.fromString(snap[Fields.type]),
        category: snap[Fields.category],
        image: snap[Fields.image],
        price: snap[Fields.price].toDouble(),
        sellingPrice: snap[Fields.sellingPrice].toDouble(),
        commissionType: CommissionTypeX.fromSymbol(snap[Fields.commissionType]),
        commission: snap[Fields.commission].toDouble(),
        featured: snap[Fields.featured],
        newProduct: snap[Fields.newProduct],
        recommended: snap[Fields.recommended],
        bestSeller: snap.data().toString().contains(Fields.bestSeller)
            ? snap[Fields.bestSeller]
            : false,
        averageRating: snap[Fields.averageRating].toDouble(),
        totalRating: snap[Fields.totalRating].toDouble(),
        totalUsers: snap[Fields.totalUsers],
        likes: snap[Fields.likes],
        sold: snap[Fields.sold],
        status: snap[Fields.status] is bool
            ? snap[Fields.status]
            : snap[Fields.status] == "true"
                ? true
                : false,
        createdAt: snap[Fields.createdAt],
        updatedAt: snap[Fields.updatedAt],
        description: snap[Fields.description],
        createdBy: snap.data().toString().contains(Fields.createdBy)
            ? snap[Fields.createdBy]
            : null,
        updatedBy: snap.data().toString().contains(Fields.updatedBy)
            ? snap[Fields.updatedBy]
            : null,
      );

  @override
  String toString() =>
      'Product(id: $id, restaurantId: $restaurantId, name: $name, type: $type, category: $category, image: $image, price: $price, sellingPrice: $sellingPrice, commissionType: $commissionType, commission: $commission, featured: $featured, newProduct: $newProduct, recommended: $recommended, bestSeller: $bestSeller, averageRating: $averageRating, totalRating: $totalRating, totalUsers: $totalUsers, likes: $likes, sold: $sold, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, createdBy: $createdBy, updatedBy: $updatedBy)';

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.restaurantId == restaurantId &&
        other.name == name &&
        other.type == type &&
        other.category == category &&
        other.image == image &&
        other.price == price &&
        other.sellingPrice == sellingPrice &&
        other.commissionType == commissionType &&
        other.commission == commission &&
        other.featured == featured &&
        other.newProduct == newProduct &&
        other.recommended == recommended &&
        other.bestSeller == bestSeller &&
        other.averageRating == averageRating &&
        other.totalRating == totalRating &&
        other.totalUsers == totalUsers &&
        listEquals(other.likes, likes) &&
        other.sold == sold &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.description == description &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      restaurantId.hashCode ^
      name.hashCode ^
      type.hashCode ^
      category.hashCode ^
      image.hashCode ^
      price.hashCode ^
      sellingPrice.hashCode ^
      commissionType.hashCode ^
      commission.hashCode ^
      featured.hashCode ^
      newProduct.hashCode ^
      recommended.hashCode ^
      bestSeller.hashCode ^
      averageRating.hashCode ^
      totalRating.hashCode ^
      totalUsers.hashCode ^
      likes.hashCode ^
      sold.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      description.hashCode ^
      createdBy.hashCode ^
      updatedBy.hashCode;
}
