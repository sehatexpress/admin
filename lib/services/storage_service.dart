import 'dart:io' show File;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../providers/auth_provider.dart';

final _storage = FirebaseStorage.instance;

class StorageService {
  final String uid;
  const StorageService(this.uid);

  /// Upload an image and return its download URL
  Future<String> uploadImage({
    required String folder,
    required File image,
    String? imgID,
    SettableMetadata? metadata,
  }) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = imgID?.trim().isNotEmpty == true
          ? imgID!
          : '$uid-$timestamp';
      final path = '$folder/$fileName';

      final ref = _storage.ref(path);
      final uploadTask = await ref.putFile(image, metadata);
      return await uploadTask.ref.getDownloadURL();
    } catch (e, st) {
      Error.throwWithStackTrace(e.firebaseErrorMessage, st);
    }
  }

  /// get image URL
  Future<String> getImage(String folder, {String? id}) async {
    try {
      return await _storage.ref('$folder/${id ?? uid}').getDownloadURL();
    } catch (e, st) {
      Error.throwWithStackTrace(e.firebaseErrorMessage, st);
    }
  }

  /// delete image
  Future<void> deleteImage(String imgOrPath) async {
    try {
      final ref = imgOrPath.startsWith('http')
          ? _storage.refFromURL(imgOrPath)
          : _storage.ref(imgOrPath);
      await ref.delete();
    } catch (e, st) {
      Error.throwWithStackTrace(e.firebaseErrorMessage, st);
    }
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return StorageService(uid);
});
