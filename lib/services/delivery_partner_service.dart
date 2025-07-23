import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/delivery_partner_model.dart';
import '../providers/auth_provider.dart';

class DeliveryPartnerService {
  final Ref ref;
  final String uid;
  const DeliveryPartnerService(this.ref, this.uid);

  Stream<List<DeliveryPartnerModel>> getDeliveryPartners(String? city) {
    try {
      final colRef = city == null
          ? Collections.deliveryPartners
              .orderBy(Fields.updatedAt, descending: true)
          : Collections.deliveryPartners
              .where(Fields.city, isEqualTo: city.translatedCity)
              .orderBy(Fields.updatedAt, descending: true);
      return colRef.snapshots().map((docs) => docs.docs
          .map((doc) => DeliveryPartnerModel.fromSnapshot(doc))
          .toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // update active status
  Future<void> updateVerificationStatus({
    required String uid,
    required String status,
  }) async {
    try {
      await Collections.deliveryPartners.doc(uid).update({
        Fields.verificationStatus: status,
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedBy: uid,
      });
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final deliveryPartnerServiceProvider = Provider<DeliveryPartnerService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return DeliveryPartnerService(ref, uid);
});
