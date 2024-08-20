import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../models/league_model.dart';
import '../../../../../../services/dio_service.dart';
import '../../pages/leagues/paid_league_detail_paid.dart';

class PaidLeaguesPageController extends GetxController {
  List<LeagueModel> leagues = [];

  getLeagues() async {
    try {
      var response =
          await DioService.dio.get<String>(DioService.LEAGUE_PAID_API);
      if (response.statusCode == 200) {
        var list = leagueModelFromJson(response.data!);
        leagues = list;
        update();
      }
    } on Exception catch (e) {
      print("$e");
    }
  }

  callLeagueDetail(LeagueModel league, context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return PaidLeagueDetailPage(
        id: league.id!,
      );
    }));
  }
}
