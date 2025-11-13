import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../services/auth_service.dart';
import 'global_providers.dart';

class AuthStateNotifier extends StateNotifier<User?> {
  final Ref ref;
  final AuthService _auth;

  // Initializing notifier
  AuthStateNotifier(this.ref, this._auth) : super(_auth.currentUser) {
    _auth.authStateChanges.listen((user) {
      state = user;
    });
  }

  // 🔹 Logout
  Future<void> logout() async {
    if (state == null) {
      ref.read(messageProvider.notifier).state = Strings.loginBeforeProceeding;
      return;
    }

    await ref.withLoading(() async {
      await _auth.logout();
      state = null;
      ref.read(messageProvider.notifier).state = 'Logged out successfully!';
    });
  }
}

// 🔹 StateNotifierProvider
final authProvider = StateNotifierProvider<AuthStateNotifier, User?>((ref) {
  final auth = ref.read(authServiceProvider);
  return AuthStateNotifier(ref, auth);
});

// 🔹 Provider to get the user UID
final authUidProvider = Provider<String?>(
  (ref) => ref.watch(authProvider)?.uid,
);
