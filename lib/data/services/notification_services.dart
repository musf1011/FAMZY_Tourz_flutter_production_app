import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  // 🔹 Instances
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // 🔹 Navigator key (for notification navigation later)
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // 🔹 Android Notification Channel
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'new_package',
    'New Package',
    description: 'New package notification',
    importance: Importance.high,
  );

  // 🔹 CALL AFTER LOGIN
  Future<void> initialize() async {
    debugPrint("🔔 Initializing Notification Service");

    // 1️⃣ Permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      debugPrint("❌ Notification permission denied");
      return;
    }

    debugPrint("✅ Notification permission granted");

    // 2️⃣ Get FCM token
    String? token = await _messaging.getToken();
    debugPrint("📱 FCM Token: $token");

    if (token != null) {
      await _saveTokenToFirestore(token);
    }

    // 3️⃣ Token refresh listener
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint("🔄 Token refreshed");
      _saveTokenToFirestore(newToken);
    });

    // 4️⃣ Local notifications setup
    await _setupLocalNotifications();

    // 5️⃣ Foreground message
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 6️⃣ Notification tapped (background)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint("📲 Notification clicked (background)");
      _handleNotificationClick(message);
    });

    // 7️⃣ App opened from terminated state
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      debugPrint("🚀 App opened from terminated notification");
      _handleNotificationClick(initialMessage);
    }
  }

  // 🔹 SAVE TOKEN TO FIRESTORE
  Future<void> _saveTokenToFirestore(String token) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      debugPrint("❌ User not logged in");
      return;
    }

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
      {'fcmToken': token},
      SetOptions(merge: true),
    );

    debugPrint("✅ FCM Token saved to Firestore");
  }

  // 🔹 LOCAL NOTIFICATION SETUP
  Future<void> _setupLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        debugPrint("🔔 Local notification clicked");
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    debugPrint("✅ Local notifications initialized");
  }

  // 🔹 FOREGROUND HANDLER
  void _handleForegroundMessage(RemoteMessage message) {
    if (kDebugMode) {
      debugPrint("📬 Foreground notification received");
      debugPrint("Title: ${message.notification?.title}");
      debugPrint("Body: ${message.notification?.body}");
    }

    _showLocalNotification(message);
  }

  // 🔹 SHOW LOCAL NOTIFICATION
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails =
        NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      id: message.hashCode,
      title: message.notification?.title ?? "New Notification",
      body: message.notification?.body ?? "",
      notificationDetails: notificationDetails,
    );
  }

  // 🔹 HANDLE NOTIFICATION CLICK
  void _handleNotificationClick(RemoteMessage message) {
    debugPrint("➡ Navigating from notification");

    // Example:
    // navigatorKey.currentState?.pushNamed('/details');
  }
}

// 🔹 BACKGROUND / TERMINATED HANDLER (TOP LEVEL)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("📬 Background notification: ${message.notification?.title}");
}
