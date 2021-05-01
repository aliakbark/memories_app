import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:memories_app/src/managers/memories.dart';
import 'package:memories_app/src/managers/object_factory.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FirebaseManager {
  FirebaseManager();

  FirebaseMessaging? _firebaseMessaging;
  FirebaseAnalytics? _firebaseAnalytics;
  FirebaseAnalyticsObserver? _firebaseAnalyticsObserver;

  Future<void> init() async {
    if (Firebase.apps.isEmpty) {
      final app = await Firebase.initializeApp();
      print('Initialized default app $app');
    }
    await _initializeAnalytics();
    await _initializeMessaging();
  }

  /// Initialize firebase messaging services
  Future<FirebaseMessaging> _initializeMessaging() async {
    _firebaseMessaging = FirebaseMessaging.instance;

    // For request permissions.
    final notificationSettings = await _firebaseMessaging?.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _firebaseMessaging?.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await _firebaseMessaging?.subscribeToTopic(Memories.memoriesMobile);

    _firebaseMessaging?.onTokenRefresh.listen((token) async {
      ObjectFactory().prefs.setFCMToken(token);
    });

    return Future.value(_firebaseMessaging);
  }

  Future<FirebaseMessaging> get firebaseMessaging async {
    if (_firebaseMessaging != null) return Future.value(_firebaseMessaging);

    await _initializeMessaging();
    return Future.value(_firebaseMessaging);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    /// If you're going to use other Firebase services in the background, such as Firestore,
    /// make sure you call `initializeApp` before using other Firebase services.*/

    print('Handling a background message: ${message.messageId}');
  }

  /// Initialize firebase analytics
  Future<FirebaseAnalyticsObserver> _initializeAnalytics() async {
    _firebaseAnalytics = FirebaseAnalytics();
    _firebaseAnalyticsObserver =
        FirebaseAnalyticsObserver(analytics: _firebaseAnalytics!);
    return Future.value(_firebaseAnalyticsObserver);
  }

  FirebaseAnalyticsObserver get firebaseAnalyticsObserver {
    if (_firebaseAnalyticsObserver != null) return _firebaseAnalyticsObserver!;

    _initializeAnalytics();
    return _firebaseAnalyticsObserver!;
  }
}
