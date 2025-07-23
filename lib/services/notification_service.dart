import 'dart:developer' as console;
import 'dart:math' show Random;

import 'package:firebase_messaging/firebase_messaging.dart'
    show AuthorizationStatus, FirebaseMessaging, RemoteMessage;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _handlerBackgroundMessage(RemoteMessage message) async {
  console.log("message: ${message.toMap()}");
  // message: {senderId: null, category: null, collapseKey: com.sehatexpress.admin, contentAvailable: false, data: {}, from: 577785414038, messageId: 0:1727031331042373%28f6fac028f6fac0, messageType: null, mutableContent: false, notification: {title: Notification title, titleLocArgs: [], titleLocKey: null, body: Notification detail, bodyLocArgs: [], bodyLocKey: null, android: {channelId: null, clickAction: null, color: null, count: null, imageUrl: null, link: null, priority: 0, smallIcon: null, sound: null, ticker: null, tag: campaign_collapse_key_2077485445227910921, visibility: 0}, apple: null, web: null}, sentTime: 1727031331029, threadId: null, ttl: 2419200}
  console.log('Title: ${message.notification?.title}');
  console.log('Body: ${message.notification?.body}');
  console.log('Payload: ${message.data}');
}

void backgroundNotificationResponseHandler(NotificationResponse response) {
  console.log('Notification tapped in the background: ${response.payload}');
  // Perform any other logic you need here
}

const String _channelId = 'sehatexpress_admin';
const String _channelName = 'Sehat Express Admin Notifications';
const String _channelDescription = 'Notifications for Sehat Express Admin App';

class NotificationService {
  final FlutterLocalNotificationsPlugin localNotifications;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationService(this.localNotifications);

  // subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
    } catch (e) {
      console.log('ERROR while subscribeToTopic ${e.toString()}');
    }
  }

  // unsubscribe from all notification
  Future<void> unsubscribeToAll() async {
    try {
      await _firebaseMessaging.deleteToken();
    } catch (e) {
      console.log('ERROR while unsubscribeToAll ${e.toString()}');
    }
  }

  // handle message for notification
  void _handleMessage(RemoteMessage? message) {
    if (message == null) return;
    console.log('Notification Message: ${message.toMap()}');
    console.log('Notification Title: ${message.notification!.title}');
    console.log('Notification Body: ${message.notification!.body}');
    console.log('Notification Payload: ${message.data}');
  }

  // create android notification channel
  Future<void> _createAndroidNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId, // Channel ID
      _channelName, // Channel name
      description: _channelDescription, // Description
      importance: Importance.high,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // initialize notification service
  Future<void> initNotification() async {
    try {
      console.log('Initializing Firebase Messaging and Local Notifications...');

      // Create Android notification channel
      await _createAndroidNotificationChannel();

      // Request notification permissions
      await _firebaseMessaging.requestPermission().then((val) {
        if (val.authorizationStatus != AuthorizationStatus.authorized) {
          console.log(
              'Notifications not authorized. Request permissions in device settings.');
        } else {
          console.log('Notification permissions granted.');
        }
      });

      // Define initialization settings for both platforms
      const AndroidInitializationSettings androidInitializationSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings darwinInitializationSettings =
          DarwinInitializationSettings();

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings,
      );

      // Initialize local notifications
      await localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (response) {
          console.log('Notification tapped: ${response.payload}');
        },
        onDidReceiveBackgroundNotificationResponse:
            backgroundNotificationResponseHandler,
      );

      // Handle notifications
      FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
      FirebaseMessaging.onBackgroundMessage(_handlerBackgroundMessage);
      FirebaseMessaging.onMessage.listen((message) {
        final notification = message.notification;
        if (notification == null) return;

        console.log('Displaying notification: ${notification.title}');
        localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              _channelId,
              _channelName,
              channelDescription: _channelDescription,
              importance: Importance.high,
              priority: Priority.high,
              enableLights: true,
            ),
            iOS: DarwinNotificationDetails(),
          ),
        );
      });

      console.log('Notification setup complete.');
    } catch (e) {
      console.log('Error during notification initialization: ${e.toString()}');
      rethrow;
    }
  }

  // send local notification
  Future<void> sendLocalNotification(
    String title,
    String body, {
    String? payload,
  }) async {
    var rng = Random();
    var id = rng.nextInt(900000) + 100000;

    try {
      final androidNotificationDetails = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        styleInformation: BigTextStyleInformation(
          body,
          htmlFormatBigText: true,
          contentTitle: title,
          htmlFormatContentTitle: true,
        ),
        priority: Priority.high,
      );

      final notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(),
      );

      await localNotifications.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } catch (error) {
      console.log('Error sending notification: $error');
    }
  }

  // get device token
  Future<String?> getDeviceToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      console.log('message121 ${e.toString()}');
      rethrow;
    }
  }
}

final notificationService =
    NotificationService(FlutterLocalNotificationsPlugin());
