import 'package:football/models/match_model.dart';
import 'package:football/models/matchweek_model.dart';
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

  List<MatchModel> matches = [];
  MatchweekModel matchweekModel = MatchweekModel();
  List<Player> reservePlayers = [];
  List<Player> primaryTeam = [];

  getCurrentMatches() async {
    var response = await DioService.dio.get(DioService.CURRENT_MATCHWEEK);
    if (response.statusCode == 200) {
      var matchweek = MatchweekModel.fromJson(response.data);
      var response2 = await DioService.dio
          .get(DioService.GET_MATCHES_API + matchweek.id.toString());
      if (response2.statusCode == 200) {
        var model = matchModelFromJson(response2.data);
        matches = model;
        update();
      }
    }
  }

  getReservePLayers() {
    List<Player> list = [];
    for (var player in team.players!) {
      if (!player.isPrimary!) {
        list.add(player);
      }
    }
    reservePlayers = list;
    update();
  }

  getTeam() async {
    String userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    var result = teamModelFromJson(response);
    team = result;
    teamName = team.name!;
    await getPoints();
    isLoading = true;
    getReservePLayers();
    update();
  }

  getPoints() async {
    var response = await DioService.GET(DioService.POINT_STATISTICS_API, null);
    points = pointModelFromJson(response);
  }
}
