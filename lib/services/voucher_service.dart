import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/enums.dart';
import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/voucher_model.dart';
import '../providers/auth_provider.dart';
import '../providers/global_providers.dart';

class VoucherService {
  final Ref ref;
  final String uid;
  const VoucherService(this.ref, this.uid);

  // get all vouchers list
  Stream<List<VoucherModel>> getVouchers(String? city) {
    try {
      if (city != null) {
        return Collections.vouchers
            .where('city', isEqualTo: city)
            .orderBy('updatedAt', descending: true)
            .snapshots()
            .map((docs) => docs.docs
                .map((doc) => VoucherModel.fromSnapshot(doc))
                .toList());
      } else {
        return Collections.vouchers
            .orderBy('updatedAt', descending: true)
            .snapshots()
            .map((docs) => docs.docs
                .map((doc) => VoucherModel.fromSnapshot(doc))
                .toList());
      }
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // addnew voucher
  Future<void> newVoucher({
    required String code,
    required double value,
    required String type,
    required double minimumOrder,
    required String beginDate,
    required String? expiryDate,
    required double upto,
    required String? restaurantId,
    required String? userId,
    required bool status,
    required List<String> conditions,
    final String? createdBy,
    final String? updatedBy,
    required bool expired,
    required String? city,
  }) async {
    try {
      var map = {
        Fields.code: code.toUpperCase(),
        Fields.value: value,
        Fields.type: type,
        Fields.minimumOrder: minimumOrder,
        Fields.beginDate: beginDate,
        Fields.expiryDate: expiryDate,
        Fields.upto: upto,
        Fields.status: true,
        Fields.restaurantId: restaurantId,
        Fields.userId: userId,
        Fields.city: city,
        Fields.createdBy: uid,
        Fields.createdAt: DateTime.now().millisecondsSinceEpoch,
        Fields.users: [],
        Fields.conditions: conditions,
        Fields.updatedAt: null,
        Fields.updatedBy: null,
      };
      await Collections.vouchers.add(map);
      ref.read(globalProvider.notifier).updateMessage(
            'New voucher created successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // update voucher status
  Future<void> toggleVoucherStatus(String doc, bool status) async {
    try {
      await Collections.vouchers.doc(doc).update({
        Fields.status: status,
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedBy: uid,
      });

      ref.read(globalProvider.notifier).updateMessage(
            'Voucher ${status ? 'enabled' : 'disabled'} successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // delete voucher
  Future<void> deleteVoucher(String id) async {
    try {
      await Collections.vouchers.doc(id).delete();
      ref.read(globalProvider.notifier).updateMessage(
            'Voucher deleted successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final voucherServiceProvider = Provider<VoucherService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return VoucherService(ref, uid);
});
