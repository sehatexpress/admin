import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/admin_model.dart';
import '../providers/auth_provider.dart';

class AdminService {
  final String uid;
  const AdminService(this.uid);

  // check for duplicate email/mobile
  Future<bool> checkDuplicateEmailMobile(String data) async {
    try {
      final field = data.contains('@') ? Fields.email : Fields.mobile;
      return await Collections.creators
          .where(field, isEqualTo: data)
          .get()
          .then(
            (x) => x.docs.isNotEmpty,
            onError: (e) => throw e,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // disable admin
  Future<void> disableEnableAdmin(String uid, bool status) async {
    try {
      await Collections.creators.doc(uid).update({
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedBy: uid,
      });
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get admin detail
  Stream<AdminModel> getAdminInfo() {
    try {
      return Collections.creators
          .doc(uid)
          .snapshots()
          .map((x) => AdminModel.fromSnapshot(x));
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get all admin lists
  Stream<List<AdminModel>> getAllAdminList() {
    try {
      return Collections.creators
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((e) => AdminModel.fromSnapshot(e)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get admins created by current user
  Stream<List<AdminModel>> getAllAdminCreatedByUID() {
    try {
      return Collections.creators
          .where(Fields.createdBy, isEqualTo: uid)
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((e) => AdminModel.fromSnapshot(e)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final adminServiceProvider = Provider<AdminService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return AdminService(uid);
});
