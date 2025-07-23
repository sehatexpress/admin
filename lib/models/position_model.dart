import 'package:cloud_firestore/cloud_firestore.dart';

class PositionModel {
  final String geohash;
  final GeoPoint geopoint;
  const PositionModel({
    required this.geohash,
    required this.geopoint,
  });

  Map<String, dynamic> toDocument() => {
        'geohash': geohash,
        'geopoint': geopoint,
      };

  factory PositionModel.fromSnapshot(Map<String, dynamic> snap) =>
      PositionModel(
        geohash: snap['geohash'],
        geopoint: snap['geopoint'],
      );
}
