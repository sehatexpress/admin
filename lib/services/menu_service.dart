import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/enums.dart';
import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/menu_model.dart';
import '../providers/auth_provider.dart';
import '../providers/global_providers.dart';

class MenuService {
  final Ref ref;
  final String uid;
  const MenuService(this.ref, this.uid);

  Stream<List<MenuModel>> getMenusList() {
    try {
      return Collections.menus
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map(
            (docs) => docs.docs.map((doc) => MenuModel.fromMap(doc)).toList(),
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> addMenu({
    required String name,
    required String description,
    required String image,
    required String categoryId,
    required double price,
    required String cityId,
    required String locationId,
    required int quantity,
    required Map<String, dynamic> nutritions,
    int status = 1,
  }) async {
    try {
      var map = {
        Fields.name: name.toLowerCase(),
        Fields.description: description,
        Fields.image: image,
        'categoryId': categoryId,
        Fields.price: price,
        'cityId': cityId,
        'locationId': locationId,
        Fields.quantity: quantity,
        Fields.sold: 0,
        'nutritions': nutritions,
        Fields.status: status,
        Fields.createdBy: uid,
        Fields.createdAt: DateTime.now().toIso8601String(),
        Fields.updatedAt: null,
        Fields.updatedBy: null,
      };
      await Collections.menus.add(map);
      ref
          .read(globalProvider.notifier)
          .updateMessage(
            'New menu created successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> updateMenu({
    required String id,
    required String name,
    required String description,
    required String image,
    required String categoryId,
    required double price,
    required String cityId,
    required String locationId,
    required int quantity,
    required Map<String, dynamic> nutritions,
    int status = 1,
  }) async {
    try {
      var map = {
        Fields.name: name.toLowerCase(),
        Fields.description: description,
        Fields.image: image,
        'categoryId': categoryId,
        Fields.price: price,
        'cityId': cityId,
        'locationId': locationId,
        Fields.quantity: quantity,
        'nutritions': nutritions,
        Fields.status: status,
        Fields.updatedBy: uid,
        Fields.updatedAt: DateTime.now().toIso8601String(),
      };
      await Collections.menus.doc(id).update(map);
      ref
          .read(globalProvider.notifier)
          .updateMessage(
            'Menu updated successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> toggleMenuStatus(String doc, bool status) async {
    try {
      await Collections.menus.doc(doc).update({
        Fields.status: status,
        Fields.updatedAt: DateTime.now().toIso8601String(),
        Fields.updatedBy: uid,
      });

      ref
          .read(globalProvider.notifier)
          .updateMessage(
            'Menu ${status ? 'enabled' : 'disabled'} successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> deleteMenu(String id) async {
    try {
      await Collections.menus.doc(id).delete();
      ref
          .read(globalProvider.notifier)
          .updateMessage(
            'Menu deleted successfully!',
            type: MessageType.success,
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final menuServiceProvider = Provider<MenuService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return MenuService(ref, uid);
});
