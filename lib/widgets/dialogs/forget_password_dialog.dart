import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/strings.dart';
import '../../providers/auth_provider.dart';
import '../../providers/global_providers.dart';
import '../inputs/email_input.dart';

class ForgetPasswordDialog extends HookConsumerWidget {
  const ForgetPasswordDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var formKey = useMemoized(() => GlobalKey<FormState>());
    var email = useTextEditingController();
    return AlertDialog(
      title: Text('Forgot Password'),
      content: Form(
        key: formKey,
        child: EmailInput(controller: email),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        OutlinedButton(
          onPressed: () async {
            try {
              if (formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                await ref
                    .read(authProvider.notifier)
                    .sendPasswordResetLink(email.text.trim());
                Navigator.pop(context);
                ref.read(messageProvider.notifier).state =
                    Strings.passwordResetLink;
              }
            } catch (_) {}
          },
          child: const Text("Send Email"),
        ),
      ],
    );
  }
}
