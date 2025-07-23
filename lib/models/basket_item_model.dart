import 'package:flutter/foundation.dart';

import '../config/enums.dart';
import '../config/extensions.dart';
import '../config/strings.dart';
import 'product_model.dart';

@immutable
class BasketItemModel {
  final String id;
  final String name;
  final String image;
  final String category;
  final num commission;
  final CommissionTypeEnum commissionType;
  final num price;
  final num sellingPrice;
  final int quantity;
  const BasketItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.commission,
    required this.commissionType,
    required this.price,
    required this.sellingPrice,
    required this.quantity,
  });

  BasketItemModel copyWith({
    String? id,
    String? name,
    String? image,
    String? category,
    num? commission,
    CommissionTypeEnum? commissionType,
    num? price,
    num? sellingPrice,
    int? quantity,
  }) =>
      BasketItemModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        category: category ?? this.category,
        commission: commission ?? this.commission,
        commissionType: commissionType ?? this.commissionType,
        price: price ?? this.price,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        quantity: quantity ?? this.quantity,
      );

  Map<String, dynamic> toDocument() => {
        Fields.id: id,
        Fields.name: name,
        Fields.image: image,
        Fields.category: category,
        Fields.commission: commission,
        Fields.commissionType: commissionType.symbol,
        Fields.price: price,
        Fields.sellingPrice: sellingPrice,
        Fields.quantity: quantity,
      };

  factory BasketItemModel.fromProduct(ProductModel snap) => BasketItemModel(
        id: snap.id,
        name: snap.name,
        image: snap.image!,
        category: snap.category,
        commission: snap.commission,
        commissionType: snap.commissionType,
        price: snap.price,
        sellingPrice: snap.sellingPrice,
        quantity: 1,
      );

  factory BasketItemModel.fromSnapshot(Map<String, dynamic> snap) =>
      BasketItemModel(
        id: snap[Fields.id],
        name: snap[Fields.name],
        image: snap[Fields.image],
        category: snap[Fields.category],
        commission: snap[Fields.commission],
        commissionType: CommissionTypeX.fromSymbol(snap[Fields.commissionType]),
        price: snap[Fields.price],
        sellingPrice: snap.toString().contains(Fields.sellingPrice)
            ? snap[Fields.sellingPrice]
            : snap[Fields.price],
        quantity: snap[Fields.quantity],
      );

  @override
  String toString() =>
      'BasketItem(id: $id, name: $name, image: $image, category: $category, commission: $commission, commissionType: $commissionType, price: $price, sellingPrice: $sellingPrice, quantity: $quantity)';

  @override
  bool operator ==(covariant BasketItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.category == category &&
        other.commission == commission &&
        other.commissionType == commissionType &&
        other.price == price &&
        other.sellingPrice == sellingPrice &&
        other.quantity == quantity;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      category.hashCode ^
      commission.hashCode ^
      commissionType.hashCode ^
      price.hashCode ^
      sellingPrice.hashCode ^
      quantity.hashCode;
}
