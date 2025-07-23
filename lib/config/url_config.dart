import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openGoogleMap(
  String origin,
  double originLatitude,
  double originLongitude,
  String destination,
  double destinationLatitude,
  double destinationLongitude,
) async {
  await MapLauncher.showDirections(
    directionsMode: DirectionsMode.driving,
    mapType: MapType.google,
    originTitle: origin,
    origin: Coords(originLatitude, originLongitude),
    destinationTitle: destination,
    destination: Coords(destinationLatitude, destinationLongitude),
  );
}

Future<void> openCall(String phone) async {
  await launchUrl(Uri.parse('tel:+977$phone'));
}
