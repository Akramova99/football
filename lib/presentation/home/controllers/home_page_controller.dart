import 'package:flutter/material.dart';
import 'package:football/models/user_data_model.dart';
import 'package:football/presentation/home/pages/settings_pages/pages/notification_page.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

import '../../../models/notification_model.dart';

class HomePageController extends GetxController {
  String name = "";
  String dayTime = "";
  String userId = "";
  UserModel user = UserModel();

  List<FirebaseNotification> notifications = [];

  getNotification() async {
    userId = DbService.getUserId();
    var path = "/api/v1/users/$userId/notifications?page=0&size=100";
    var response = await DioService.dio.get<String>(path);

    if (response.statusCode == 200) {
      if (response.data != null) {
        var list = notificationModelFromJson(response.data!);
        notifications = list.notifications!;
      }
    }
    update();
  }

  getUserData() async {
    userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.USER_DATA_API + userId, null);
    user = userModelFromJson(response);
    name = user.username!;
    update();
  }

  callNotificationPage(context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return const NotificationPage();
    }));
    getUserData();
    getNotification();
  }
}
