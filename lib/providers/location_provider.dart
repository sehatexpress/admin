import 'package:geolocator/geolocator.dart' show GeolocatorPlatform, Position;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show Ref, StateNotifier, StateNotifierProvider;

import '../config/strings.dart' show LocationStrings;
import '../services/location_service.dart';
import '../states/location_state.dart';
import 'global_providers.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) => LocationNotifier(ref),
);

class LocationNotifier extends StateNotifier<LocationState> {
  final Ref ref;
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;

  LocationNotifier(this.ref) : super(LocationState());

  Future<void> requestLocation() async {
    try {
      ref.read(globalProvider.notifier).updateLoading(true);
      bool enabled =
          await ref.read(locationServiceProvider).checkLocationPermission();
      if (!enabled) throw LocationStrings.locationDenied;
      state = state.copyWith(enabled: enabled);
      await init();
    } catch (e) {
      _handleError(e);
    } finally {
      ref.read(globalProvider.notifier).updateLoading(false);
    }
  }

  void updateCity(String? city) => state = state.copyWith(city: city);

  Future<void> updateCords({
    required double latitude,
    required double longitude,
  }) async {
    try {
      ref.read(globalProvider.notifier).updateLoading(true);
      await _updateLocation(latitude, longitude);
    } catch (e) {
      _handleError(e);
    } finally {
      ref.read(globalProvider.notifier).updateLoading(false);
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      ref.read(globalProvider.notifier).updateLoading(true);
      var pos = await ref.read(locationServiceProvider).getCurrentLocation();
      await _updateLocation(pos.latitude, pos.longitude);
    } catch (e) {
      _handleError(e);
    } finally {
      ref.read(globalProvider.notifier).updateLoading(false);
    }
  }

  Future<void> _updateLocation(double lat, double lng) async {
    try {
      final loc = await ref.read(locationServiceProvider).getAddress(lat, lng);
      state = state.copyWith(
        latitude: lat,
        longitude: lng,
        location: loc,
        city: loc.city,
      );
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> init({bool load = false}) async {
    try {
      ref.read(globalProvider.notifier).updateLoading(true);
      Position cords = await _geolocator.getCurrentPosition();
      await _updateLocation(cords.latitude, cords.longitude);
    } catch (e) {
      _handleError(e);
    } finally {
      ref.read(globalProvider.notifier).updateLoading(false);
    }
  }

  Future<void> searchLocation(String search) async {
    try {
      ref.read(globalProvider.notifier).updateLoading(true);
      final result =
          await ref.read(locationServiceProvider).getLocationBySearch(search);
      state = state.copyWith(searchedLocations: result);
    } catch (e) {
      _handleError(e);
    } finally {
      ref.read(globalProvider.notifier).updateLoading(false);
    }
  }

  void setFocusedLocation(int i) =>
      state = state.copyWith(focusedLocationIndex: i);

  void clear() {
    state = state.copyWith(
      search: null,
      searchedLocations: [],
      focusedLocationIndex: 0,
    );
  }

  void _handleError(dynamic e) {
    ref.read(globalProvider.notifier).updateMessage(e.toString());
    state = state.copyWith(enabled: false);
  }
}
