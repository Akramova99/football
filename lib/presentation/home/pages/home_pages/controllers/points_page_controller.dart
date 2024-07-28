import 'package:get/get.dart';

class PointsPageController extends GetxController {
  String teamName = "";
  String? teamIcon;
  int points = 0;

  getTeam() {
    teamName = "Arsenal";
    update();
  }

}
