import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/banner_model.dart';
import '../providers/auth_provider.dart';
import '../providers/global_providers.dart';
import 'storage_service.dart';

class BannerService {
  final Ref ref;
  final String uid;
  const BannerService(this.ref, this.uid);

  // get banner images list
  Stream<List<BannerModel>> getBannerImages(String? city) {
    try {
      final colRef = city == null
          ? Collections.banners.orderBy(Fields.updatedAt, descending: true)
          : Collections.banners
              .where(Fields.city, isEqualTo: city.translatedCity)
              .orderBy(Fields.createdAt, descending: true);
      return colRef.snapshots().map((docs) =>
          docs.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // upload banner images images
  Future<void> uploadBannerImages(
    String? restaurantId,
    List<File> images,
    String? city,
  ) async {
    if (images.isEmpty) return;
    try {
      ref.read(globalProvider.notifier).updateLoading(true);
      final storage = ref.read(storageServiceProvider);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final uploads = <Future<void>>[];

      for (int i = 0; i < images.length; i++) {
        final file = images[i];
        final uniquePath = '$timestamp-$i';
        final upload = _uploadSingleBanner(
          storage,
          file,
          uniquePath,
          restaurantId,
          city,
        );
        uploads.add(upload);
      }
      await Future.wait(uploads);
    } catch (e) {
      throw e.firebaseErrorMessage;
    } finally {
      ref.read(globalProvider.notifier).updateLoading(false);
    }
  }

  Future<void> _uploadSingleBanner(
    StorageService storage,
    File image,
    String path,
    String? restaurantId,
    String? city,
  ) async {
    final imageUrl = await storage.uploadImage(
      folder: 'banners/$path',
      image: image,
    );

    final now = DateTime.now().millisecondsSinceEpoch;

    final data = {
      Fields.status: true,
      Fields.imageUrl: imageUrl,
      Fields.restaurantId: restaurantId,
      Fields.city: city,
      Fields.createdAt: now,
      Fields.createdBy: uid,
      Fields.updatedAt: null,
      Fields.updatedBy: null,
    };

    await Collections.banners.doc(path).set(data);
  }

  // delete banner image
  Future<void> deleteBannerImage(String doc, String image) async {
    try {
      await ref.read(storageServiceProvider).deleteImage(image);
      await Collections.banners.doc(doc).delete();
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final bannerServiceProvider = Provider<BannerService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return BannerService(ref, uid);
});
