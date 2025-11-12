import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/enums.dart';
import '../../config/extensions.dart';
import '../../models/delivery_partner_model.dart';
import '../../providers/lists_provider.dart';
import '../../providers/location_provider.dart';
import '../../widgets/generic/custom_rating_bar.dart';
import '../../widgets/generic/data_view_widget.dart';

class DeliveryPartnerLocationScreen extends HookConsumerWidget {
  const DeliveryPartnerLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customInfoWindowController = useMemoized(
      () => CustomInfoWindowController(),
    );
    final mapController = useState<GoogleMapController?>(null);
    final carouselController = useMemoized(() => CarouselSliderController());
    final markers = useState<Map<MarkerId, Marker>>({});

    void addUserInfoWindow(DeliveryPartnerModel user) {
      final position = user.position!.geopoint;
      final address = ref.read(
        locationProvider.select((state) => state.location),
      );

      if (address == null) return;

      customInfoWindowController.addInfoWindow!(
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(address.city), Text(address.displayName)],
          ),
        ),
        LatLng(position.latitude, position.longitude),
      );
    }

    void addMarkers(List<DeliveryPartnerModel> users) {
      final newMarkers = <MarkerId, Marker>{};

      for (int i = 0; i < users.length; i++) {
        final user = users[i];
        if (user.position == null) continue;

        final markerId = MarkerId(user.uid);
        newMarkers[markerId] = Marker(
          markerId: markerId,
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(
            user.position!.geopoint.latitude,
            user.position!.geopoint.longitude,
          ),
          onTap: () {
            carouselController.animateToPage(i).then((_) {
              addUserInfoWindow(user);
            });
          },
        );
      }

      markers.value = newMarkers;
    }

    return DataViewWidget(
      provider: deliveryPartnerListProvider,
      dataBuilder: (partners) {
        final users = partners
            .where(
              (u) =>
                  u.verificationStatus == VerificationStatusEnum.verified &&
                  u.position != null,
            )
            .toList();

        if (users.isEmpty) {
          return const Center(
            child: Text("No verified delivery partners found."),
          );
        }

        addMarkers(users);

        final firstUserPosition = users[0].position!.geopoint;

        return Stack(
          children: [
            GoogleMap(
              mapType: MapType.satellite,
              myLocationEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  firstUserPosition.latitude,
                  firstUserPosition.longitude,
                ),
                zoom: 15.6,
                tilt: 45,
              ),
              markers: markers.value.values.toSet(),
              onMapCreated: (controller) {
                mapController.value = controller;
                customInfoWindowController.googleMapController = controller;
                addUserInfoWindow(users[0]);
              },
              onTap: (_) => customInfoWindowController.hideInfoWindow!(),
              onCameraMove: (_) => customInfoWindowController.onCameraMove!(),
            ),
            CustomInfoWindow(
              controller: customInfoWindowController,
              height: 55,
              width: 200,
              offset: 50,
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: CarouselSlider(
                items: users
                    .map((user) => DeliveryBoyLocationCardWidget(user: user))
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  height: 100,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    final user = users[index];
                    if (user.position != null) {
                      customInfoWindowController.hideInfoWindow!();
                      addUserInfoWindow(user);
                      mapController.value?.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                              user.position!.geopoint.latitude,
                              user.position!.geopoint.longitude,
                            ),
                            zoom: 15.6,
                            tilt: 45,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DeliveryBoyLocationCardWidget extends StatelessWidget {
  final DeliveryPartnerModel user;
  const DeliveryBoyLocationCardWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${user.name}, ${user.mobile}', style: context.text.bodyMedium),
          Text(user.email, style: context.text.bodyMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomRatingBar(
                    initial: user.averageRating ?? 0,
                    onRatingUpdate: (_) {},
                  ),
                  Text('(${user.totalUsers})', style: context.text.bodyMedium),
                ],
              ),
              Text(
                'Total Delivery: ${user.totalDelivery}',
                style: context.text.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
