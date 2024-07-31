import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/statistics/pages/player_detail_page.dart';
import 'package:get/get.dart';

import '../../../../../models/team_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';

class StatisticsPageController extends GetxController {
  List<Player> players = [];

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

  callPLayerDetailPage(Player player, context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayerDetailPage(player: player);
    }));
  }

}
