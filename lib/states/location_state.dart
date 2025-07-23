import 'package:flutter/foundation.dart' show immutable;

import '../models/location_model.dart';

@immutable
class LocationState {
  final bool enabled;
  final double latitude;
  final double longitude;
  final String? city;
  final LocationModel? location;
  final String? search;
  final List<LocationModel> searchedLocations;
  final int focusedLocationIndex;

  const LocationState({
    this.enabled = false,
    this.latitude = 0,
    this.longitude = 0,
    this.city,
    this.location,
    this.search,
    this.searchedLocations = const [],
    this.focusedLocationIndex = 0,
  });

  LocationState copyWith({
    bool? enabled,
    double? latitude,
    double? longitude,
    String? city,
    LocationModel? location,
    String? search,
    List<LocationModel>? searchedLocations,
    int? focusedLocationIndex,
  }) =>
      LocationState(
        enabled: enabled ?? this.enabled,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        city: city ?? this.city,
        location: location ?? this.location,
        search: search ?? this.search,
        searchedLocations: searchedLocations ?? this.searchedLocations,
        focusedLocationIndex: focusedLocationIndex ?? this.focusedLocationIndex,
      );

  @override
  String toString() =>
      'LocationState(enabled: $enabled, latitude: $latitude, longitude: $longitude, city: $city, location: $location, search: $search, searchedLocations: $searchedLocations, focusedLocationIndex: $focusedLocationIndex)';

  @override
  bool operator ==(covariant LocationState other) {
    if (identical(this, other)) return true;

    return other.enabled == enabled &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.city == city &&
        other.location == location &&
        other.search == search &&
        other.searchedLocations == searchedLocations &&
        other.focusedLocationIndex == focusedLocationIndex;
  }

  @override
  int get hashCode =>
      enabled.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      city.hashCode ^
      location.hashCode ^
      search.hashCode ^
      searchedLocations.hashCode ^
      focusedLocationIndex;
}
