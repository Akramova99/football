import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/statistics/pages/player_detail_page.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../models/statistic_model.dart';
import '../../../../../models/team_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';

class StatisticsPageController extends GetxController {
  List<Player> players = [];
  List<StatisticModel> statics = [];

  getPlayers() async {
    String userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    var result = teamModelFromJson(response);
    if (result.players != null) {
      players = result.players!;
      update();
    }
  }

  getStatistics() async {
    var response = await DioService.GET(
        "${DioService.PLAYER_STATISTIC}FORWARD&clubId=2", null);

    statics = statisticModelFromJson(response);
    update();
    Logger().e(statics[0].playerNumber);

  }

  callPLayerDetailPage(Player player, context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayerDetailPage(player: player);
    }));
  }
}
