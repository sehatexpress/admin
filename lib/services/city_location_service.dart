import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/city_location_model.dart';
import '../providers/auth_provider.dart';
import '../providers/global_providers.dart';

class CityLocationService {
  final Ref ref;
  final String uid;
  const CityLocationService(this.ref, this.uid);

  Stream<List<CityLocationModel>> getCityLocationList() {
    try {
      return Collections.cityLocation
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map(
            (docs) =>
                docs.docs.map((doc) => CityLocationModel.fromMap(doc)).toList(),
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> addCityLocation({
    required String name,
    required String description,
    required String cityId,
    required double deliveryCharge,
    int status = 1,
  }) async {
    try {
      var map = {
        Fields.name: name.toLowerCase(),
        Fields.description: description,
        Fields.cityId: cityId,
        Fields.deliveryCharge: deliveryCharge,
        Fields.status: status,
        Fields.createdBy: uid,
        Fields.createdAt: isoDateTimeString,
        Fields.updatedAt: null,
        Fields.updatedBy: null,
      };
      await Collections.cityLocation.add(map);
      ref.read(messageProvider.notifier).state =
          'New city location created successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> updateCityLocation({
    required String id,
    required String name,
    required String description,
    required String cityId,
    required double deliveryCharge,
    int status = 1,
  }) async {
    try {
      var map = {
        Fields.name: name.toLowerCase(),
        Fields.description: description,
        Fields.cityId: cityId,
        Fields.deliveryCharge: deliveryCharge,
        Fields.status: status,
        Fields.updatedBy: uid,
        Fields.updatedAt: isoDateTimeString,
      };
      await Collections.cityLocation.doc(id).update(map);
      ref.read(messageProvider.notifier).state =
          'City location updated successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> toggleCityLocationStatus(String doc, bool status) async {
    try {
      await Collections.cityLocation.doc(doc).update({
        Fields.status: status,
        Fields.updatedAt: isoDateTimeString,
        Fields.updatedBy: uid,
      });

      ref.read(messageProvider.notifier).state =
          'City location ${status ? 'enabled' : 'disabled'} successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> deleteCityLocation(String id) async {
    try {
      await Collections.cityLocation.doc(id).delete();
      ref.read(messageProvider.notifier).state =
          'City location deleted successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final cityLocationServiceProvider = Provider<CityLocationService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return CityLocationService(ref, uid);
});
