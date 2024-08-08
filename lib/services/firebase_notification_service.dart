import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:football/models/notification_model.dart';
import 'package:football/services/db_service.dart';

class FirebaseNotificationService {
  static final firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initNotification() async {
    await firebaseMessaging.requestPermission();
    final token = await firebaseMessaging.getToken();
    print("-----------------------------------------------------------------");
    print("token: " + token!);
  }


  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    //await Firebase.initializeApp();
    print("Handling a background message: ${message.notification?.title}");
    print("Handling a background message: ${message.notification?.body}");


    final notification = NotificationResponseModel(
        id: message.messageId!,
        title: message.notification?.title ?? "",
        body: message.notification?.body ?? "",
        image: message.notification?.android?.imageUrl,
        createdDate: message.sentTime,
        viewed: false);
    DbService.list.add(notification);
    print(DbService.list.length);
  }
}
