import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../config/typo_config.dart';
import '../../models/setting_model.dart';
import '../../providers/lists_provider.dart';
import '../../services/setting_service.dart';
import '../../widgets/city/add_update_city_widget.dart';
import '../../widgets/generic/loader_widget.dart';

class CitySettingScreen extends ConsumerWidget {
  const CitySettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citySettingsAsync = ref.watch(citySettingListProvider);

    return Scaffold(
      body: citySettingsAsync.when(
        data: (data) => ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemCount: data.length,
          itemBuilder: (_, i) => _CityCard(setting: data[i], ref: ref),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
        ),
        error: (_, __) => Center(
          child: Text(
            'Something went wrong. Please try again later.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        loading: () => const LoaderWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCityForm(context),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  void _showCityForm(BuildContext context, {SettingModel? setting}) {
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
        child: AddUpdateCityWidget(setting: setting),
      ),
    );
  }
}

class _CityCard extends StatelessWidget {
  final SettingModel setting;
  final WidgetRef ref;

  const _CityCard({required this.setting, required this.ref});

  @override
  Widget build(BuildContext context) {
    final textStyle = typoConfig.textStyle.smallCaptionSubtitle2;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 8),
          _infoText('Base Delivery Distance', '${setting.baseDeliveryKM} KM',
              textStyle),
          _infoText('Base Delivery Charge', '${setting.baseDeliveryCharge}',
              textStyle),
          _infoText('Free Delivery For New User',
              '${setting.freeDelivery} Orders', textStyle),
          _infoText('Free Delivery Distance For New User',
              '${setting.freeDeliveryKM} KM', textStyle),
          _infoText('Delivery Charge Per KM', '${setting.perKM}', textStyle),
          _infoText(
              'Max Delivery Distance', '${setting.radiusKM} KM', textStyle),
          _infoText(
              'Minimum Order Value', '${setting.minimumOrder}', textStyle),
        ],
      ),
    );
  }

  Widget _infoText(String label, String value, TextStyle style) {
    return Text('$label: $value', style: style);
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          setting.id,
          style: typoConfig.textStyle.smallCaptionLabelMedium,
        ),
        SizedBox(
          width: 30,
          height: 30,
          child: PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            padding: EdgeInsets.zero,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 0, child: Text('Edit')),
              PopupMenuItem(value: 1, child: Text('Delete')),
            ],
            onSelected: (value) => _onMenuSelect(context, value),
          ),
        ),
      ],
    );
  }

  void _onMenuSelect(BuildContext context, int value) {
    switch (value) {
      case 0:
        _showCityForm(context);
        break;
      case 1:
        context
            .showGenericDialog(
          title: 'Delete City Setting',
          content: 'Are you sure you want to delete this setting?',
        )
            .then((confirmed) {
          if (confirmed == true) {
            ref.read(settingServiceProvider).deleteCitySetting(setting.id);
          }
        });
        break;
    }
  }

  void _showCityForm(BuildContext context) {
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
        child: AddUpdateCityWidget(setting: setting),
      ),
    );
  }
}
