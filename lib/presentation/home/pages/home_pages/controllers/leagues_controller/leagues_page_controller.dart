import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/league_detail_page.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

import '../../../../../../models/league_model.dart';

class LeaguesPageController extends GetxController {
  List<LeagueModel> leagues = [];

  getLeagues() async {
    var userId = DbService.getUserId();
    try {
      var response =
          await DioService.dio.get<String>(DioService.LEAGUE_EXTRA_API);
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
      return LeagueDetailPage(id: league.id!);
    }));
  }

  callNextPage(Widget widget, context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
    getLeagues();
  }
}
