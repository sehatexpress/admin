import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/category_model.dart';
import '../providers/auth_provider.dart';
import 'storage_service.dart';

class CategoryService {
  final Ref ref;
  final String uid;
  const CategoryService(this.ref, this.uid);

  // get stream list of category
  Stream<List<CategoryModel>> getCategories(String? city) {
    try {
      final colRef = city == null
          ? Collections.categories.orderBy(Fields.updatedAt, descending: true)
          : Collections.categories
              .where(Fields.cities, arrayContains: city.translatedCity)
              .orderBy(Fields.updatedAt, descending: true);

      return colRef.snapshots().map((docs) =>
          docs.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // add new category
  Future<void> newCategory({
    required String name,
    required File image,
    List<String> cities = const [],
  }) async {
    try {
      var imageURL = await ref
          .read(storageServiceProvider)
          .uploadImage(folder: Fields.categories, image: image);
      final map = {
        Fields.name: name.toLowerCase(),
        Fields.image: imageURL,
        Fields.status: true,
        Fields.createdBy: uid,
        Fields.createdAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedAt: null,
        Fields.updatedBy: null,
        Fields.cities: cities.map((e) => e.toLowerCase()).toList(),
      };
      await Collections.categories.add(map);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // update category
  Future<void> updateCategory({
    required String name,
    required String docID,
    File? image,
    List<String> cities = const [],
  }) async {
    try {
      final notifier = ref.read(storageServiceProvider);
      var map = {
        Fields.name: name.toLowerCase(),
        Fields.cities: cities.map((e) => e.toLowerCase()),
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedBy: uid,
      };
      if (image != null) {
        final imgrUrl = await notifier.uploadImage(
          folder: Fields.categories,
          image: image,
        );
        map[Fields.image] = imgrUrl;
      }
      await Collections.categories.doc(docID).update(map);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // delete category
  Future<void> deleteCategory({
    required String image,
    required String doc,
  }) async {
    try {
      await ref.read(storageServiceProvider).deleteImage(image);
      await Collections.categories.doc(doc).delete();
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final categoryServiceProvider = Provider<CategoryService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return CategoryService(ref, uid);
});
