import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/force_update_provider.dart';
import '../providers/global_providers.dart';
import '../services/notification_service.dart';
import '../states/global_state.dart';
import 'auth_screen.dart';
import 'helper/force_update_screen.dart';
import 'helper/loading_screen.dart';
import 'helper/message_screen.dart';
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
          : NoInternetScreen.instance().show(context: context);
    });

    // Listen to global state for loading, messages, and order placement
    ref.listen<GlobalState>(globalProvider, (prev, next) {
      if (prev?.loading != next.loading) {
        next.loading
            ? LoadingScreen.instance().show(context: context)
            : LoadingScreen.instance().hide();
      }

      if (prev?.message != next.message) {
        next.message != null
            ? MessageScreen.instance().show(
                context: context,
                global: next,
                ref: ref,
              )
            : MessageScreen.instance().hide();
      }
    });

    // Listen for force update trigger
    ref.listen<bool>(updateCheckerProvider, (_, shouldUpdate) {
      if (shouldUpdate) {
        ForceUpdateScreen.instance().show(context: context);
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
