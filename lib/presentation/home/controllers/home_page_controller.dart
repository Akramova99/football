import 'package:flutter/material.dart';
import 'package:football/models/user_data_model.dart';
import 'package:football/presentation/home/pages/settings_pages/pages/notification_page.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  String name = "";
  String dayTime = "";
  String userId = "";
  UserModel user = UserModel();

  getUserData() async {
    userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.USER_DATA_API + userId, null);
    user = userModelFromJson(response);
    name = user.username!;
    update();
  }

  setDayTime(DateTime time) {
    if (time.hour >= 5 && time.hour < 12) {
      dayTime = 'Morning';
      update();
    } else if (time.hour >= 12 && time.hour < 17) {
      dayTime = 'Afternoon';
      update();
    } else if (time.hour >= 17 && time.hour < 21) {
      dayTime = 'Evening';
      update();
    } else {
      dayTime = 'Night';
      update();
    }
  }

  goToSettingsPage(PageController pageController) {
    pageController.animateToPage(3,
        duration: const Duration(milliseconds: 10), curve: Curves.easeIn);
  }

  callNotificationPage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return NotificationPage();
    }));
  }
}
