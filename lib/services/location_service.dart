import 'dart:convert' show jsonDecode;

import 'package:flutter/foundation.dart' show kIsWeb, immutable;
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionActions, PermissionStatus, openAppSettings;

import '../config/constants.dart' show LocationConstant;
import '../config/strings.dart' show LocationStrings, Strings;
import '../models/location_model.dart';

@immutable
class LocationService {
  const LocationService();

  // Check and request location permission
  Future<bool> checkLocationPermission() async {
    try {
      final permissionStatus = await Permission.location.request();
      switch (permissionStatus) {
        case PermissionStatus.granted:
          return true;

        case PermissionStatus.denied:
        case PermissionStatus.restricted:
          throw LocationStrings.locationDenied;

        case PermissionStatus.permanentlyDenied:
          await openAppSettings();
          throw LocationStrings.locationDeniedPermanently;
        default:
          // Handle unexpected cases gracefully
          throw LocationStrings.locationUnexpectedError;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // get current location
  Future<Position> getCurrentLocation() async {
    try {
      var pos = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return pos;
    } catch (e) {
      throw e.toString();
    }
  }

  // get address from laitude & longitude
  Future<LocationModel> getAddress(double lat, double lng) async {
    try {
      var uri = Uri.parse(
          '${LocationConstant.openStreetbaseURl}/reverse?lat=$lat&lon=$lng&format=jsonv2');
      var response = await http.get(
        uri,
        headers: {
          'User-Agent': LocationConstant.userAgent,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return LocationModel.fromMap(data);
      } else {
        throw response.reasonPhrase ?? Strings.error;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // search location
  Future<List<LocationModel>> getLocationBySearch(String search) async {
    try {
      var uri = Uri.parse(
          '${LocationConstant.openStreetbaseURl}/${LocationConstant.openStreetSearch}$search');
      var response = await http.get(
        uri,
        headers: {
          'User-Agent': LocationConstant.userAgent,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data
            .map<LocationModel>((e) => LocationModel.fromSearchMap(e))
            .toList();
      } else {
        throw response.reasonPhrase ?? Strings.error;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // calculate delivery distance
  Future<double> getDeliveryDistance(
    String origin,
    String destination,
  ) async {
    try {
      var url =
          '${LocationConstant.googleMapDistanceURL}?destinations=$destination&origins=$origin&key=${LocationConstant.mapWebKEY}&mode=walking';
      if (kIsWeb) {
        url = '${LocationConstant.corsURL}$url';
      }
      Map<String, String>? header = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers':
            'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale',
        'Access-Control-Allow-Methods': 'GET,POST, OPTIONS'
      };
      var response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'OK' &&
            data['rows'] != null &&
            data['rows'].isNotEmpty &&
            data['rows'][0]['elements'] != null &&
            data['rows'][0]['elements'].isNotEmpty &&
            data['rows'][0]['elements'][0]['status'] == 'OK') {
          var distance = data['rows'][0]['elements'][0]['distance']['value'];
          return distance / 1000;
        } else {
          throw 'Something went wrong while calculating distance.';
        }
      } else {
        throw response.reasonPhrase ?? Strings.error;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

final locationServiceProvider = Provider((_) => LocationService());
