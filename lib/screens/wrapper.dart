import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../providers/auth_provider.dart';
import '../providers/global_providers.dart';
import '../services/notification_service.dart';
import 'auth_screen.dart';
import 'helper/loading_screen.dart';
import 'helper/no_internet_screen.dart';
import 'root/root_screen.dart';

class Wrapper extends HookConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to connectivity changes
    ref.listen<AsyncValue<List<ConnectivityResult>>>(connectivityProvider, (
      _,
      result,
    ) {
      final hasConnection =
          result.value?.any((r) => r != ConnectivityResult.none) ?? false;
      hasConnection
          ? NoInternetScreen.instance().hide()
          : NoInternetScreen.instance().show(context);
    });

    // Listen to global state for loading
    ref.listen<bool>(loadingProvider, (prev, next) {
      if (prev != next) {
        next
            ? LoadingScreen.instance().show(context)
            : LoadingScreen.instance().hide();
      }
    });

    // Listen to global state for messages
    ref.listen<String?>(messageProvider, (prev, next) {
      if (prev != next) {
        if (next != null) {
          context.showSnackbar(next);
        }
      }
    });

    // Subscribe user to notifications
    ref.listen<String?>(authUidProvider, (prevUid, newUid) {
      if (newUid != null && !kIsWeb) {
        notificationService.subscribeToTopic(newUid);
      }
    });

    final authState = ref.watch(authProvider);

    return authState != null ? const RootScreen() : const AuthScreen();
  }
}
