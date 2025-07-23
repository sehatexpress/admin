import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../config/extensions.dart';
import '../config/constants.dart';
import '../config/enums.dart';
import '../config/strings.dart';
import '../config/utils.dart';
import '../providers/auth_provider.dart';
import '../providers/global_providers.dart';
import 'admin_service.dart';

class CloudFunctionsService {
  final Ref ref;
  final String uid;
  const CloudFunctionsService(this.ref, this.uid);

  // create user
  Future<void> createNewUser({
    required int gender,
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      var id = generateRandomString(28);
      final Map<String, dynamic> data = {
        Fields.uid: id,
        Fields.name: name.trim(),
        Fields.gender: gender.toString(),
        Fields.mobile: mobile.trim(),
        Fields.email: email.trim(),
        Fields.password: password.trim(),
        Fields.type: 'user',
      };
      final response = await http.post(ApiUrl.createUserAPI, body: data);
      if (response.statusCode == 200) {
        ref
            .read(globalProvider.notifier)
            .updateMessage(
              'New user created successfully!',
              type: MessageType.success,
            );
      } else {
        throw 'Something went wrong!';
      }
    } catch (e) {
      e.firebaseErrorMessage;
    }
  }

  // create delivery partner
  Future<void> createDeliveryPartner({
    required int gender,
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String address,
    required String city,
  }) async {
    try {
      var id = generateRandomString(28);
      final Map<String, dynamic> data = {
        Fields.uid: id,
        Fields.name: name.trim(),
        Fields.gender: gender.toString(),
        Fields.mobile: mobile.trim(),
        Fields.email: email.trim(),
        Fields.address: address.trim(),
        Fields.city: city,
        Fields.password: password.trim(),
        Fields.type: 'delivery',
        Fields.createdBy: uid,
      };
      final response = await http.post(ApiUrl.createUserAPI, body: data);

      if (response.statusCode == 200) {
        ref
            .read(globalProvider.notifier)
            .updateMessage(
              'New delivery partner added. can be logged in from delivery partner app!',
              type: MessageType.success,
            );
      } else {
        throw 'Something went wrong!';
      }
    } catch (e) {
      e.firebaseErrorMessage;
    }
  }

  // update user password
  Future<void> updatePassword({
    required String uid,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> data = {
        Fields.uid: uid,
        Fields.password: password.trim(),
        Fields.action: 'password',
      };
      final res = await http.post(ApiUrl.updateUserAPI, body: data);
      if (res.statusCode == 200) {
        ref
            .read(globalProvider.notifier)
            .updateMessage(
              'Password updated successfully!',
              type: MessageType.success,
            );
      } else {
        throw 'Something went wrong!';
      }
    } catch (e) {
      e.firebaseErrorMessage;
    }
  }

  // update user
  Future<void> updateUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(ApiUrl.updateUserAPI, body: data);
      if (response.statusCode == 200) {
        ref
            .read(globalProvider.notifier)
            .updateMessage(
              'User updated successfully!',
              type: MessageType.success,
            );
      } else {
        throw 'Something went wrong!';
      }
    } catch (e) {
      e.firebaseErrorMessage;
    }
  }

  // disable user
  Future<void> disableUser(String uid) async {
    try {
      final Map<String, dynamic> data = {
        Fields.uid: uid,
        Fields.action: 'disable',
      };
      final response = await http.post(ApiUrl.updateUserAPI, body: data);
      if (response.statusCode == 200) {
        ref
            .read(globalProvider.notifier)
            .updateMessage(
              'User disabled successfully!',
              type: MessageType.success,
            );
      } else {
        throw 'Something went wrong!';
      }
    } catch (e) {
      e.firebaseErrorMessage;
    }
  }

  // delete user
  Future<void> deleteUser(String uid, String type) async {
    try {
      final response = await http.post(
        ApiUrl.deleteUserAPI,
        body: {Fields.uid: uid, type: type},
      );

      if (response.statusCode == 200) {
        ref
            .read(globalProvider.notifier)
            .updateMessage(
              'User deleted successfully!',
              type: MessageType.success,
            );
      } else {
        throw 'Something went wrong!';
      }
    } catch (e) {
      e.firebaseErrorMessage;
    }
  }

  // create delivery partner
  Future<void> updateProductAvailability(String uID, bool status) async {
    try {
      await http.post(
        ApiUrl.updateProductsStatus,
        body: {Fields.uid: uID, Fields.status: status.toString()},
      );
    } catch (e) {
      e.firebaseErrorMessage;
    }
  }

  // disable user
  Future<void> createAdmin({
    required String name,
    required String email,
    required String mobile,
    required String role,
    required String city,
  }) async {
    try {
      var notifier = ref.read(adminServiceProvider);
      var emailExist = await notifier.checkDuplicateEmailMobile(email);
      if (emailExist) {
        throw 'Email already in user. Please use another!';
      }
      var mobileExist = await notifier.checkDuplicateEmailMobile(mobile);
      if (mobileExist) {
        throw 'Mobile already in user. Please use another!';
      }
      final Map<String, dynamic> data = {
        Fields.name: name,
        Fields.email: email,
        Fields.mobile: mobile,
        Fields.role: role,
        Fields.city: city,
        Fields.createdBy: uid,
      };
      final response = await http.post(ApiUrl.createAdminUserAPI, body: data);
      if (response.statusCode == 200) {
        ref
            .read(globalProvider.notifier)
            .updateMessage(
              'New admin created successfully!',
              type: MessageType.success,
            );
      } else {
        throw 'Something went wrong!';
      }
    } catch (e) {
      e.firebaseErrorMessage;
    }
  }
}

final cloudFunctionsServiceProvider = Provider<CloudFunctionsService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return CloudFunctionsService(ref, uid);
});
