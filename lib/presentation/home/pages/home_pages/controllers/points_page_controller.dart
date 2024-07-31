import 'package:football/models/point_model.dart';
import 'package:football/models/team_model.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class PointsPageController extends GetxController {
  String teamName = "";
  String? teamIcon;
  int point = 0;
  TeamModel team = TeamModel();
  PointModel points = PointModel();
  bool isLoading = false;

  List<Player> reservePlayers = [];

  getTeam() async {
    String userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    var result = teamModelFromJson(response);
    team = result;
    teamName = team.name!;
    getPoints();
    isLoading = true;
    update();
  }

  getPoints() async {
    var response = await DioService.GET(DioService.POINT_STATISTICS_API, null);
    points = pointModelFromJson(response);
  }
}
