import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/setting_model.dart';
import '../providers/auth_provider.dart';

class SettingService {
  final String uid;
  const SettingService(this.uid);

  // get all settings
  Stream<List<SettingModel>> getAllSettings() {
    try {
      return Collections.settings
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((doc) => SettingModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get city setting
  Stream<SettingModel> getCitySettings(String city) {
    try {
      return Collections.settings
          .doc(city.toUpperCase())
          .snapshots()
          .map((doc) => SettingModel.fromSnapshot(doc));
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get city setting
  Future<SettingModel?> getIndividualCitySettings(String city) async {
    try {
      var res = await Collections.settings.doc(city.toUpperCase()).get();
      if (res.exists) {
        return SettingModel.fromSnapshot(res);
      }
      return null;
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // add settings for city
  Future<void> addCitySetting({
    required String name,
    required double baseDeliveryCharge,
    required int baseDeliveryKM,
    required int radiusKM,
    required double perKM,
    required int freeDelivery,
    required int freeDeliveryKM,
    required double minimumOrder,
  }) async {
    try {
      var map = {
        Fields.city: name.toLowerCase(),
        Fields.baseDeliveryCharge: baseDeliveryCharge,
        Fields.baseDeliveryKM: baseDeliveryKM,
        Fields.radiusKM: radiusKM,
        Fields.perKM: perKM,
        Fields.freeDelivery: freeDelivery,
        Fields.freeDeliveryKM: freeDeliveryKM,
        Fields.minimumOrder: minimumOrder,
        Fields.createdAt: DateTime.now().millisecondsSinceEpoch,
        Fields.createdBy: uid,
        Fields.updatedBy: null,
        Fields.updatedAt: null,
      };
      await Collections.settings.doc(name.toUpperCase()).set(map);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // add settings for city
  Future<void> updateCitySetting({
    required String docId,
    required double baseDeliveryCharge,
    required int baseDeliveryKM,
    required int radiusKM,
    required double perKM,
    required int freeDelivery,
    required int freeDeliveryKM,
    required double minimumOrder,
  }) async {
    try {
      var map = {
        Fields.baseDeliveryCharge: baseDeliveryCharge,
        Fields.baseDeliveryKM: baseDeliveryKM,
        Fields.radiusKM: radiusKM,
        Fields.perKM: perKM,
        Fields.freeDelivery: freeDelivery,
        Fields.freeDeliveryKM: freeDeliveryKM,
        Fields.minimumOrder: minimumOrder,
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedBy: uid,
      };
      await Collections.settings.doc(docId).update(map);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // delete settings for city
  Future<void> deleteCitySetting(String docId) async {
    try {
      await Collections.settings.doc(docId).delete();
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final settingServiceProvider = Provider<SettingService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return SettingService(uid);
});
