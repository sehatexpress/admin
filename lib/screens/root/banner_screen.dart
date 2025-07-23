import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../models/banner_model.dart';
import '../../providers/lists_provider.dart';
import '../../services/banner_service.dart';
import '../../widgets/banner/add_update_banner_widget.dart';
import '../../widgets/generic/custom_image_provider.dart';
import '../../widgets/generic/loader_widget.dart';

class BannerScreen extends ConsumerWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannersAsync = ref.watch(bannersListProvider);

    return bannersAsync.when(
      data: (banners) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: StaggeredGrid.count(
            crossAxisCount: context.isMobile
                ? 2
                : context.isTablet
                    ? 3
                    : 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: banners
                .map((banner) => _BannerTile(banner: banner, ref: ref))
                .toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 24,
                ),
                child: const AddUpdateBannerWidget(),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      error: (error, _) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: LoaderWidget()),
    );
  }
}

class _BannerTile extends StatelessWidget {
  final BannerModel banner;
  final WidgetRef ref;

  const _BannerTile({required this.banner, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CustomImageProvider(image: banner.imageUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircleAvatar(
              backgroundColor: Colors.white70,
              child: IconButton(
                icon: const Icon(Icons.delete_rounded, color: Colors.red),
                onPressed: () => context
                    .showGenericDialog(
                  title: 'Delete Banner',
                  content: 'Are you sure you want to delete this banner?',
                )
                    .then((res) {
                  if (res == true) {
                    ref
                        .read(bannerServiceProvider)
                        .deleteBannerImage(banner.id, banner.imageUrl);
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
