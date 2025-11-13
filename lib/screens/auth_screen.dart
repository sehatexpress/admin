import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../services/auth_service.dart';
import '../services/http_service.dart';
import '../widgets/generic/submit_button.dart';
import '../widgets/inputs/otp_input.dart';
import '../widgets/inputs/phone_input.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(httpServiceProvider);
    final phone = useTextEditingController();
    final otpSent = useState<bool>(false);
    final otp = useState<String?>(null);

    Future<void> requestOTP() async {
      ref.withLoading(() async {
        final txt = phone.text.trim();
        FocusScope.of(context).unfocus();
        if (txt.isNotEmpty && txt.length == 10) {
          Map<String, dynamic>? result = await notifier.requestOTP(txt);
          if (result.isNotEmpty &&
              result.containsKey('success') &&
              result['success'] == true) {
            context.showSnackbar(result['message']);
            otpSent.value = true;
          } else {
            throw result['message'];
          }
        } else {
          throw 'Please enter your 10 digit phone number!';
        }
      });
    }

    Future<void> verifyOTP() async {
      await ref.withLoading(() async {
        FocusScope.of(context).unfocus();
        if (otp.value != null && otp.value!.length == 4) {
          final phoneTxt = phone.text.trim();
          Map<String, dynamic>? result = await notifier.verifyOTP(
            phone: phoneTxt,
            otp: otp.value!,
          );
          if (result.isNotEmpty &&
              result.containsKey('success') &&
              result['success'] == true) {
            final res = await notifier.getAuthToken(phoneTxt);
            if (res.isNotEmpty &&
                res.containsKey('success') &&
                res['success'] == true) {
              final token = res['token'];
              if (token != null) {
                await ref.read(authServiceProvider).loginWithToken(token);
              } else {
                context.showSnackbar(
                  'You are not registered. Please sign up first.',
                );
              }
            } else {
              throw res['message'];
            }
          } else {
            throw result['message'];
          }
        } else {
          throw 'Please enter your 4 digit OTP sent to your phone!';
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: PhoneInput(
                      controller: phone,
                      enabled: !otpSent.value,
                    ),
                  ),
                  if (otpSent.value)
                    IconButton(
                      onPressed: () => otpSent.value = false,
                      icon: const Icon(Icons.edit),
                    ),
                ],
              ),
              if (otpSent.value)
                OtpInputField(onCompleted: (x) => otp.value = x),
              SubmitButton(
                title: otpSent.value ? 'Verify OTP' : 'Request OTP',
                icon: Icons.phone,
                onPressed: otpSent.value ? verifyOTP : requestOTP,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
