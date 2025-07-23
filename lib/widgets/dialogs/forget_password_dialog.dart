import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'
    show useMemoized, useTextEditingController;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show HookConsumerWidget, WidgetRef;

import '../../config/enums.dart' show MessageType;
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
        child: EmailInput(
          controller: email,
        ),
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
                ref.read(globalProvider.notifier).updateMessage(
                      Strings.passwordResetLink,
                      type: MessageType.success,
                    );
              }
            } catch (_) {}
          },
          child: const Text("Send Email"),
        ),
      ],
    );
  }
}
