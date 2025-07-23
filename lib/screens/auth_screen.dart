import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/constants.dart';
import '../config/typo_config.dart';
import '../providers/auth_provider.dart';
import '../widgets/dialogs/forget_password_dialog.dart';
import '../widgets/inputs/email_input.dart';
import '../widgets/inputs/password_input.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var formKey = useMemoized(() => GlobalKey<FormState>());
    var email = useTextEditingController();
    var password = useTextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              EmailInput(controller: email),
              const SizedBox(height: 12),
              PasswordInput(controller: password),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => ForgetPasswordDialog(),
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: typoConfig.textStyle.smallCaptionSubtitle2.copyWith(
                      height: 1,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Login',
                    style: typoConfig.textStyle.largeCaptionLabel3Bold
                        .copyWith(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: ColorConstants.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    try {
                      if (formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        ref.read(authProvider.notifier).login(
                              email: email.text.trim().toLowerCase(),
                              password: password.text.trim(),
                            );
                      }
                    } catch (_) {}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
