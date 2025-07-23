import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/enums.dart';
import '../config/extensions.dart';

class QueryModel {
  final String id;
  final String uid;
  final String message;
  final String mobile;
  final String name;
  // pending, in-process, closed
  final TicketStatusEnum status;
  final int createdAt;
  final String createdBy;
  final int? updatedAt;
  final String? updatedBy;
  QueryModel({
    required this.id,
    required this.uid,
    required this.message,
    required this.mobile,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  QueryModel copyWith({
    String? id,
    String? uid,
    String? message,
    String? mobile,
    String? name,
    TicketStatusEnum? status,
    int? createdAt,
    String? createdBy,
    int? updatedAt,
    String? updatedBy,
  }) =>
      QueryModel(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        message: message ?? this.message,
        mobile: mobile ?? this.mobile,
        name: name ?? this.name,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory QueryModel.fromSnapshot(DocumentSnapshot snap) => QueryModel(
        id: snap.id,
        uid: snap['uid'],
        message: snap['message'],
        name: snap['name'],
        mobile: snap['mobile'],
        status: TicketStatusEnumX.fromString(snap['status']),
        createdAt: snap['createdAt'],
        createdBy: snap['createdBy'],
        updatedAt: snap['updatedAt'],
        updatedBy: snap['updatedBy'],
      );

  @override
  String toString() =>
      'QueryModel(id: $id, uid: $uid, message: $message, mobile: $mobile, name: $name, status: $status, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy)';

  @override
  bool operator ==(covariant QueryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.message == message &&
        other.mobile == mobile &&
        other.name == name &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.createdBy == createdBy &&
        other.updatedAt == updatedAt &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uid.hashCode ^
      message.hashCode ^
      mobile.hashCode ^
      name.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      createdBy.hashCode ^
      updatedAt.hashCode ^
      updatedBy.hashCode;
}
