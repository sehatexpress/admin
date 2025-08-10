import '../models/city_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../providers/auth_provider.dart';
import '../providers/global_providers.dart';

class CityService {
  final Ref ref;
  final String uid;
  const CityService(this.ref, this.uid);

  Stream<List<CityModel>> getCitiesList() {
    try {
      return Collections.cities
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map(
            (docs) => docs.docs.map((doc) => CityModel.fromMap(doc)).toList(),
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> addCity({
    required String name,
    required String description,
    required String image,
    int status = 1,
  }) async {
    try {
      var map = {
        Fields.name: name.toLowerCase(),
        Fields.description: description,
        Fields.image: image,
        Fields.status: status,
        Fields.createdBy: uid,
        Fields.createdAt: isoDateTimeString,
        Fields.updatedAt: null,
        Fields.updatedBy: null,
      };
      await Collections.cities.add(map);
      ref.read(messageProvider.notifier).state =
          'New city created successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> updateCity({
    required String id,
    required String name,
    required String description,
    required String image,
    int status = 1,
  }) async {
    try {
      var map = {
        Fields.name: name.toLowerCase(),
        Fields.description: description,
        Fields.image: image,
        Fields.status: status,
        Fields.updatedBy: uid,
        Fields.updatedAt: isoDateTimeString,
      };
      await Collections.cities.doc(id).update(map);
      ref.read(messageProvider.notifier).state = 'City updated successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> toggleCityStatus(String doc, bool status) async {
    try {
      await Collections.cities.doc(doc).update({
        Fields.status: status,
        Fields.updatedAt: isoDateTimeString,
        Fields.updatedBy: uid,
      });

      ref.read(messageProvider.notifier).state =
          'City ${status ? 'enabled' : 'disabled'} successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> deleteCity(String id) async {
    try {
      await Collections.cities.doc(id).delete();
      ref.read(messageProvider.notifier).state = 'City deleted successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final cityServiceProvider = Provider<CityService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return CityService(ref, uid);
});
