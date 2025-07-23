import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show Provider, Ref, StateNotifier, StateNotifierProvider;

import '../config/enums.dart' show MessageType;
import '../config/strings.dart';
import '../services/auth_service.dart';
import 'global_providers.dart';

class AuthStateNotifier extends StateNotifier<User?> {
  final Ref ref;

  // Initializing notifier
  AuthStateNotifier(this.ref)
      : super(ref.read(authServiceProvider).currentUser);

  // 🔹 Utility function for reducing redundant try-catch blocks
  Future<void> _performSafeOperation(Future<void> Function() operation) async {
    try {
      ref.read(globalProvider.notifier).updateLoading(true);
      await operation();
    } catch (e) {
      ref.read(globalProvider.notifier).updateMessage(e.toString());
      log('error ${e.toString()}');
    } finally {
      ref.read(globalProvider.notifier).updateLoading(false);
      state = ref.read(authServiceProvider).currentUser;
    }
  }

  // 🔹 Login with email & password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _performSafeOperation(() async {
      await ref.read(authServiceProvider).loginWithEmailAndPassword(
            email: email,
            password: password,
          );
    });
  }

  // 🔹 Logout
  Future<void> logout() async {
    if (state == null) {
      ref
          .read(globalProvider.notifier)
          .updateMessage(Strings.loginBeforeProceeding);
      return;
    }

    await _performSafeOperation(() async {
      await ref.read(authServiceProvider).logout();
      state = null;
    });
  }

  // 🔹 Update password
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (state == null) {
      ref
          .read(globalProvider.notifier)
          .updateMessage(Strings.loginBeforeProceeding);
      return;
    }

    await _performSafeOperation(() async {
      await ref.read(authServiceProvider).changePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
          );
      ref.read(globalProvider.notifier).updateMessage(
            Strings.passwordUpdated,
            type: MessageType.success,
          );
    });
  }

  // 🔹 Send password reset link
  Future<void> sendPasswordResetLink(String email) async {
    await _performSafeOperation(() async {
      await ref.read(authServiceProvider).sendPasswordResetLink(email);
    });
  }
}

// 🔹 StateNotifierProvider
final authProvider = StateNotifierProvider<AuthStateNotifier, User?>(
  (ref) => AuthStateNotifier(ref),
);

// 🔹 Provider to get the user UID
final authUidProvider =
    Provider<String?>((ref) => ref.watch(authProvider)?.uid);
