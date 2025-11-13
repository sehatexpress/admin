import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show FirebaseErrorHandler;

final _auth = FirebaseAuth.instance;

@immutable
class AuthService {
  const AuthService();
  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // 🔹 Login with email & password
  Future<User?> loginWithToken(String token) async {
    try {
      final UserCredential userCred = await _auth.signInWithCustomToken(token);

      return userCred.user;
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final authServiceProvider = Provider<AuthService>((_) => AuthService());
