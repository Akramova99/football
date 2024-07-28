import 'package:get/get.dart';

class HomePageController extends GetxController {
  String name = "";
  String dayTime = "";

  getUserData() {
    name = "Tony";
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
}
