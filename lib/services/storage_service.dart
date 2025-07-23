import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../providers/auth_provider.dart';

final _storage = FirebaseStorage.instance;
final _firestore = FirebaseFirestore.instance;

class StorageService {
  final String uid;
  const StorageService(this.uid);

  // upload image & return url
  Future<String> uploadImage({
    required String folder,
    required File image,
    String? imgID,
  }) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '$folder/${imgID ?? '$uid-$timestamp'}';

      final ref = _storage.ref(path);
      final uploadTask = await ref.putFile(image);
      final downloadURL = await uploadTask.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get image URL
  Future<String> getImage(String folder, {String? id}) async {
    try {
      return _storage.ref('$folder/${id ?? uid}').getDownloadURL();
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // update status
  Future<void> updateImage({
    required String collection,
    required String doc,
    required String image,
  }) async {
    try {
      await _firestore.collection(collection).doc(doc).update({
        Fields.image: image,
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedBy: uid,
      });
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // delete image
  Future<void> deleteImage(String img) async {
    try {
      await _storage.refFromURL(img).delete();
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return StorageService(uid);
});
