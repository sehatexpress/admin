import 'dart:developer' as console show log;
import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/firebase_config.dart';
import '../services/notification_service.dart';

/// connectivity provider
final connectivityProvider =
    StreamProvider.autoDispose<List<ConnectivityResult>>((ref) {
  return Connectivity().onConnectivityChanged;
});

/// global state notifier
final loadingProvider = StateProvider<bool>((_) => true);
final messageProvider = StateProvider<String?>((_) => null);
final isOrderPlacedProvider = StateProvider<bool>((_) => false);
final imageSelectorProvider = StateProvider<File?>((ref) => null); 


/// APP STARTUP PROVIDER
final appStartupProvider = FutureProvider<void>((ref) async {
  try {
    console.log('Initializing app dependencies...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      // appleProvider: AppleProvider.appAttest, // or debug/deviceCheck
      // webProvider: ReCaptchaV3Provider('your-site-key'), // optional for web
    );
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    if (!kIsWeb) {
      if (kReleaseMode) {
        FlutterError.onError = (errorDetails) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        };
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
      }
      await notificationService.initNotification();
      // await notificationService.subscribeToTopic('client');
    }
    // await ref.read(locationProvider.notifier).requestLocation();
    console.log('App dependencies initialized successfully!');
  } catch (e) {
    throw e.toString();
  }
});
