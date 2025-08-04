import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/enums.dart';
import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/category_model.dart';
import '../providers/auth_provider.dart';
import '../providers/global_providers.dart';

class CategoryService {
  final Ref ref;
  final String uid;
  const CategoryService(this.ref, this.uid);

  Stream<List<CategoryModel>> getCategoriesList() {
    try {
      return Collections.categories
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map(
            (docs) =>
                docs.docs.map((doc) => CategoryModel.fromMap(doc)).toList(),
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> addCategory({
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
        Fields.createdAt: DateTime.now().toIso8601String(),
        Fields.updatedAt: null,
        Fields.updatedBy: null,
      };
      await Collections.categories.add(map);
      ref
          .read(globalProvider.notifier)
          .updateMessage(
            'New category created successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> updateCategory({
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
        Fields.updatedAt: DateTime.now().toIso8601String(),
      };
      await Collections.categories.doc(id).update(map);
      ref
          .read(globalProvider.notifier)
          .updateMessage(
            'category updated successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> toggleCategoryStatus(String doc, bool status) async {
    try {
      await Collections.categories.doc(doc).update({
        Fields.status: status,
        Fields.updatedAt: DateTime.now().toIso8601String(),
        Fields.updatedBy: uid,
      });

      ref
          .read(globalProvider.notifier)
          .updateMessage(
            'category ${status ? 'enabled' : 'disabled'} successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await Collections.categories.doc(id).delete();
      ref
          .read(globalProvider.notifier)
          .updateMessage(
            'category deleted successfully!',
            type: MessageType.success,
          );
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
