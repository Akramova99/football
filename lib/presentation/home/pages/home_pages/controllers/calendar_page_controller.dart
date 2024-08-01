import 'package:flutter/material.dart';
import 'package:football/models/match_model.dart';
import 'package:football/presentation/home/pages/home_pages/pages/calendar_pages/all_reyting_page.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

import '../../../../../models/matchweek_model.dart';
import '../../../../../models/team_reyting_model.dart';

class CalendarPageController extends GetxController {
  List<List<MatchModel>> matches = [];
  List<TeamRatingModel> teams = [];
  List<MatchweekModel> weeks = [];
  bool isDataReady = false;

  getRating() async {
    var response = await DioService.GET(DioService.GET_RATING_TEAM_API, null);
    var _teams = teamRatingModelFromJson(response);
    var size = _teams.length < 20 ? _teams.length : 20;
    for (var i = 0; i < size; i++) {
      teams.add(_teams[i]);
    }
  }

  getMatchWeeks() async {
    var response = await DioService.GET(DioService.GET_MATCHES_API, null);
    var _weeks = matchweekModelFromJson(response);
    weeks = _weeks;
  }

  getGames() async {
    List<List<MatchModel>> _list = [];
    for (var matchWeek in weeks) {
      var response = await DioService.GET(
          DioService.GET_MATCH_TEAMS_API + matchWeek.id.toString(), null);
      var list = matchModelFromJson(response);
      _list.add(list);
    }

    matches = _list;
  }

  callAllRating(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return AllRatingPage(
        teams: teams,
      );
    }));
  }

  getData() async {
    await getMatchWeeks();
    await getGames();
    await getRating();
    isDataReady = true;
    update();
  }
}
