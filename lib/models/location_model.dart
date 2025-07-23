import 'package:flutter/foundation.dart' show immutable;

import '../config/strings.dart' show Fields;

@immutable
class LocationModel {
  final double latitude;
  final double longitude;
  final String displayName;
  final String city;
  const LocationModel({
    required this.latitude,
    required this.longitude,
    required this.displayName,
    required this.city,
  });

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? displayName,
    String? city,
  }) =>
      LocationModel(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        displayName: displayName ?? this.displayName,
        city: city ?? this.city,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        Fields.latitude: latitude,
        Fields.longitude: longitude,
        Fields.displayName: displayName,
        Fields.city: city,
      };

  factory LocationModel.fromMap(Map<String, dynamic> map) => LocationModel(
        latitude: double.parse(map['lat']),
        longitude: double.parse(map['lon']),
        displayName: map['display_name'],
        city: map['address'].containsKey('city')
            ? map['address']['city']
            : map['address'].containsKey('town')
                ? map['address']['town']
                : map['address'].containsKey('municipality')
                    ? map['address']['municipality']
                    : map['address']['state_district'],
      );

  factory LocationModel.fromSearchMap(Map<String, dynamic> map) =>
      LocationModel(
        latitude: double.parse(map['lat']),
        longitude: double.parse(map['lon']),
        displayName: map['display_name'],
        city: map['name'],
      );

  @override
  String toString() =>
      'LocationModel(latitude: $latitude, longitude: $longitude, displayName: $displayName, city: $city)';

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude &&
        other.longitude == longitude &&
        other.displayName == displayName &&
        other.city == city;
  }

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      displayName.hashCode ^
      city.hashCode;
}
