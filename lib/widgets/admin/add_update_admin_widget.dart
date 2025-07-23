import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/enums.dart';
import '../../config/typo_config.dart';
import '../../models/admin_model.dart';
import '../../services/cloud_functions.service.dart';
import '../inputs/email_input.dart';
import '../inputs/mobile_input.dart';
import '../inputs/name_input.dart';
import '../inputs/select_city.dart';
import '../inputs/select_role.dart';

class AddUpdateAdminWidget extends HookConsumerWidget {
  final AdminModel? admin;
  const AddUpdateAdminWidget({super.key, this.admin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final role = useState(RoleEnum.accountant);
    final city = useState<String?>(null);
    final name = useTextEditingController(text: admin?.name ?? '');
    final email = useTextEditingController(text: admin?.email ?? '');
    final mobile = useTextEditingController(text: admin?.mobile ?? '');

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: SelectRole(
                  role: role.value,
                  onChanged: (x) {
                    if (x != null) {
                      role.value = x;
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SelectCity(
                  city: city.value,
                  onChanged: (x) => city.value = x,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          NameInput(
            required: true,
            controller: name,
            hintText: 'Name*',
          ),
          const SizedBox(height: 12),
          EmailInput(controller: email),
          const SizedBox(height: 12),
          MobileInput(
            controller: mobile,
            hintText: 'Mobile Number*',
          ),
          const SizedBox(height: 16),
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
                  final svc = ref.read(cloudFunctionsServiceProvider);

                  if (admin == null) {
                    await svc.createAdmin(
                      name: name.text.trim(),
                      email: email.text.trim(),
                      mobile: mobile.text.trim(),
                      role: role.value.name,
                      city: city.value!,
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
