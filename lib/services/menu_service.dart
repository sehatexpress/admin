import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    required num quantity,
    required Map<String, dynamic> nutritions,
    num status = 1,
  }) async {
    try {
      var map = {
        Fields.name: name.toLowerCase(),
        Fields.description: description,
        Fields.image: image,
        Fields.categoryId: categoryId,
        Fields.price: price,
        Fields.cityId: cityId,
        Fields.locationId: locationId,
        Fields.quantity: quantity,
        Fields.sold: 0,
        Fields.nutritions: nutritions,
        Fields.status: status,
        Fields.createdBy: uid,
        Fields.createdAt: isoDateTimeString,
        Fields.updatedAt: null,
        Fields.updatedBy: null,
      };
      await Collections.menus.add(map);
      ref.read(messageProvider.notifier).state =
          'New menu created successfully!';
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
        Fields.categoryId: categoryId,
        Fields.price: price,
        Fields.cityId: cityId,
        Fields.locationId: locationId,
        Fields.quantity: quantity,
        Fields.nutritions: nutritions,
        Fields.status: status,
        Fields.updatedBy: uid,
        Fields.updatedAt: isoDateTimeString,
      };
      await Collections.menus.doc(id).update(map);
      ref.read(messageProvider.notifier).state = 'Menu updated successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> toggleMenuStatus(String doc, bool status) async {
    try {
      await Collections.menus.doc(doc).update({
        Fields.status: status,
        Fields.updatedAt: isoDateTimeString,
        Fields.updatedBy: uid,
      });

      ref.read(messageProvider.notifier).state =
          'Menu ${status ? 'enabled' : 'disabled'} successfully!';
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<void> deleteMenu(String id) async {
    try {
      await Collections.menus.doc(id).delete();
      ref.read(messageProvider.notifier).state = 'Menu deleted successfully!';
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
