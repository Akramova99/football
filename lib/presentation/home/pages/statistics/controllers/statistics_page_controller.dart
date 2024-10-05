import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/statistics/pages/player_detail_page.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../models/player_detail_model.dart';
import '../../../../../models/statistic_model.dart';
import '../../../../../models/team_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';

class StatisticsPageController extends GetxController {
  PlayerDetail? players;
  List<StatisticModel> statics = [];
  bool isCheck = false;

  // Fetch player details by playerId
  getPlayers(int playerId) async {
    var response = await DioService.GET(DioService.getPlayerDetails(playerId), null);
    var result = playerDetailModelFromJson(response);
    players = result.player;
    update();
  }

  // Fetch statistics with dynamic filtering by position and club
  getStatistics({required String position, required int clubId}) async {
    var response = await DioService.GET(
        "${DioService.PLAYER_STATISTIC}$position&clubId=$clubId", null);
    statics = statisticModelFromJson(response);
    update();

  }

  // Default fetch statistics for the first club and position
  fetchDefaultStatistics() {
    getStatistics(position: "FORWARD", clubId: 1); // Default clubId and position
  }

  callPLayerDetailPage(PlayerDetail player, context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayerDetailPage(player: player);
    }));
  }
}

// parsingResponse() async {
//   String response = await DioService.GET(DioService.RANDOM_PLAYERS_API, null);
//
//   final json = jsonDecode(response);
//   players =
//       List<PlayerDetail>.from(json.map((mp) => PlayerDetail.fromJson(mp)));
//   Logger().e("Player detail length ${players.length}");
//   Logger().e("Player detail ${players[1].name}");
//   isCheck = true;
//
//   /// returned  object is News
// }