import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football/models/match_model.dart';
import 'package:football/presentation/home/pages/home_pages/pages/calendar_pages/all_reyting_page.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../models/calendar_match_model.dart';
import '../../../../../models/matchweek_model.dart';
import '../../../../../models/team_reyting_model.dart';

class CalendarPageController extends GetxController {
  List<List<MatchModel>> matches = [];
  List<TeamRatingModel> teams = [];
  List<MatchweekModel> weeks = [];
  CalendarMatch calendarMatch =CalendarMatch() ;
  bool isDataReady = false;

  // Fetches the team ratings
  getRating() async {
    var response = await DioService.GET(DioService.GET_RATING_TEAM_API, null);
    var _teams = teamRatingModelFromJson(response);
    var size = _teams.length < 20 ? _teams.length : 20;
    for (var i = 0; i < size; i++) {
      teams.add(_teams[i]);
    }
  }

  getGameStatistics()async{
    int matchId = 384303;
    var response = await DioService.GET(DioService.getMatch(matchId), null);

    Map<String, dynamic> matchData = jsonDecode(response);

    // Pass the map to the CalendarMatch model
     calendarMatch = CalendarMatch.fromJson(matchData);
    update();
    Logger().w(calendarMatch.matchId);
  }
  // Fetches the match weeks
  getMatchWeeks() async {
    var response = await DioService.GET(DioService.GET_MATCHES_API, null);
    var _weeks = matchweekModelFromJson(response);
    weeks = _weeks;
  }

  // Fetches the games for each week
  getGames() async {
    List<List<MatchModel>> _list = [];
    for (var matchWeek in weeks) {
      try {
        var response = await DioService.GET(
            DioService.GET_MATCH_TEAMS_API + matchWeek.id.toString(), null);
        var list = matchModelFromJson(response);
        _list.add(list);
      } on Exception catch (e) {
        // Handle the exception if necessary
      }
    }

    matches = _list;
  }

  // Navigates to the all ratings page
  callAllRating(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return AllRatingPage(
        teams: teams,
      );
    }));
  }

  // Fetches all required data and updates the UI
  getData() async {
    await getMatchWeeks();
    await getGames();
    await getRating();
    isDataReady = true;
    update();
  }
}
