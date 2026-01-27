import 'dart:io';

import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:e4u_application/app/di/injection.dart';
import 'package:e4u_application/app/managers/local_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';
import 'package:e4u_application/firebase/firebase_options_cloud_message.dart';

@injectable
class FirebaseMessageService {
  Future<void> initNotificaiton() async {
    // Safely initialize Firebase, handling hot restart scenarios
    try {
      await Firebase.initializeApp(
        options: DefaultCloudMessageFirebaseOptions.currentPlatform,
      );
    } on FirebaseException catch (e) {
      // If the app already exists (e.g., after hot restart), just continue
      if (e.code != 'duplicate-app') {
        rethrow;
      }
    }
    final firebaseMessaging = FirebaseMessaging.instance;
    final firebaseInAppMessaging = FirebaseInAppMessaging.instance;
    if (!kIsWeb && Platform.isAndroid) {
      final fcmToken = await firebaseMessaging.getToken();
      if (fcmToken != null) {
        await SharedPreferenceManager.saveFcmToken(fcmToken);
      }
      final firebaseInstallationId =
          await FirebaseInstallations.instance.getId();
      getIt<Logger>().i("FCMToken: $fcmToken");
      getIt<Logger>().i("InstallationId: $firebaseInstallationId");
      requestNotificationPermissions(firebaseMessaging);
      FirebaseMessaging.onBackgroundMessage(_handlerBackgorundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        getIt<Logger>().i("onMessageOpenedApp: $message");
      });
      FirebaseMessaging.onMessage.listen((message) {
        getIt<Logger>().i("onMessage: $message");
      });
      firebaseInAppMessaging.setAutomaticDataCollectionEnabled(true);
      FirebaseMessaging.onMessage.listen((message) {
        getIt<Logger>().i("onMessage: $message");
      });
    }
  }
}

Future<void> _handlerBackgorundMessage(RemoteMessage message) async {
  // Safely initialize Firebase for background isolate
  try {
    await Firebase.initializeApp();
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') {
      rethrow;
    }
  }
  getIt<Logger>().i("onBackgroundMessage: $message");
}

Future<void> requestNotificationPermissions(FirebaseMessaging messaging) async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    getIt<Logger>().i('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    getIt<Logger>().i('User granted provisional permission');
  } else {
    getIt<Logger>().i('User declined or has not accepted permission');
  }
}
