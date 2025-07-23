import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/typo_config.dart';
import '../../models/setting_model.dart';
import '../../services/setting_service.dart';
import '../inputs/setting_number_input.dart';
import '../inputs/text_input.dart';

class AddUpdateCityWidget extends HookConsumerWidget {
  final SettingModel? setting;
  const AddUpdateCityWidget({super.key, this.setting});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = useTextEditingController(text: setting?.id ?? '');
    final km =
        useTextEditingController(text: setting?.radiusKM.toString() ?? '');
    final baseDC = useTextEditingController(
        text: setting?.baseDeliveryCharge.toString() ?? '');
    final dckm = useTextEditingController(
        text: setting?.baseDeliveryKM.toString() ?? '');
    final perKM =
        useTextEditingController(text: setting?.perKM.toString() ?? '');
    final freeDelivery =
        useTextEditingController(text: setting?.freeDelivery.toString() ?? '');
    final freeDeliveryKM = useTextEditingController(
        text: setting?.freeDeliveryKM.toString() ?? '');
    final minimumOrder =
        useTextEditingController(text: setting?.minimumOrder.toString() ?? '');

    final formKey = useMemoized(() => GlobalKey<FormState>());

    Widget buildNumberField(String label, TextEditingController controller) {
      return Expanded(
        child: SettingNumberInput(
          hintText: '$label*',
          controller: controller,
        ),
      );
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextInput(
                  required: true,
                  controller: title,
                  hintText: 'City Name*',
                  enabled: setting == null,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: SettingNumberInput(
                  hintText: 'Minimum Order*',
                  controller: minimumOrder,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              buildNumberField('DC KM', dckm),
              const SizedBox(width: 8),
              buildNumberField('Delivery Charge', baseDC),
              const SizedBox(width: 8),
              buildNumberField('Radius KM', km),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              buildNumberField('Per KM', perKM),
              const SizedBox(width: 8),
              buildNumberField('Free Delivery', freeDelivery),
              const SizedBox(width: 8),
              buildNumberField('Free Delivery KM', freeDeliveryKM),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorConstants.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (formKey.currentState?.validate() != true) return;
                FocusScope.of(context).unfocus();

                try {
                  final svc = ref.read(settingServiceProvider);

                  final radius = int.parse(km.text.trim());
                  final baseCharge = double.parse(baseDC.text.trim());
                  final baseKM = int.parse(dckm.text.trim());
                  final per = double.parse(perKM.text.trim());
                  final free = int.parse(freeDelivery.text.trim());
                  final freeKM = int.parse(freeDeliveryKM.text.trim());
                  final minOrder = double.parse(minimumOrder.text.trim());

                  if (setting == null) {
                    await svc.addCitySetting(
                      name: title.text.trim(),
                      radiusKM: radius,
                      baseDeliveryCharge: baseCharge,
                      baseDeliveryKM: baseKM,
                      perKM: per,
                      freeDelivery: free,
                      freeDeliveryKM: freeKM,
                      minimumOrder: minOrder,
                    );
                  } else {
                    await svc.updateCitySetting(
                      docId: setting!.id,
                      radiusKM: radius,
                      baseDeliveryCharge: baseCharge,
                      baseDeliveryKM: baseKM,
                      perKM: per,
                      freeDelivery: free,
                      freeDeliveryKM: freeKM,
                      minimumOrder: minOrder,
                    );
                  }

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Something went wrong: $e')),
                  );
                }
              },
              child: Text(
                'Submit',
                style: typoConfig.textStyle.largeCaptionLabel3Bold
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
