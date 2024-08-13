import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:football/services/db_service.dart';

class FirebaseNotificationService {
  static final firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initNotification() async {
    await firebaseMessaging.requestPermission();
    final token = await firebaseMessaging.getToken();
    if (token != null) DbService.saveFirebaseToken(token);
    print("-----------------------------------------------------------------");
    print("token: " + token!);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}
}
