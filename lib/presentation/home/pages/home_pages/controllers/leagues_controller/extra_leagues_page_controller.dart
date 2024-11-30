import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football/services/db_service.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../../../../models/joined_team_model.dart';
import '../../../../../../models/league_detail_model.dart';
import '../../../../../../models/league_model.dart';
import '../../../../../../services/dio_service.dart';
import '../../../../../widgets/toast.dart';

class ExtraLeaguesPageController extends GetxController {
  List<LeagueModel> leagues = [];
  var userId = DbService.getUserId();
  LeagueModel myLeague = LeagueModel();
  LeagueModel myExtraLeagues = LeagueModel();
  JoinedTeamModel joinTeam = JoinedTeamModel();
  bool isJoin = false;
  String leagueId = "";

  getLeagues() async {
    print(userId);
    try {
      var response =
          await DioService.dio.get<String>(DioService.LEAGUE_EXTRA_API);
      if (response.statusCode == 200) {
        var list = leagueModelFromJson(response.data!);
        leagues = list;
        getLeague();
        update();
      }
    } on Exception catch (e) {
      print("$e");
    }
  }

  getMyLeagues() async {
    var response = await DioService.dio
        .get<String>("/api/v1/users/myLeagues?userId=$userId");
    if (response.statusCode == 200) {
      var result = leagueModelFromJson(response.data!);
      if (result.isNotEmpty) {
        myLeague = result.last;
      }
      update();
    }
  }

  getMyLeaguesDetails() async {
    var response =
        await DioService.dio.get<String>("/api/v1/leagues/available");
    if (response.statusCode == 200) {
      var result = leagueModelFromJson(response.data!);
      Logger().d(result);
      if (result.isNotEmpty) {
        myExtraLeagues = result.last;
      }
      update();
    }
  }

  getJoinedTeam() async {
    var response = await DioService.dio
        .get<String>(DioService.getLeagueStatistic(leagueId));
    if (response.statusCode == 200) {
      var result = joinedTeamFromJson(response.data!);
      Logger().d(result);
      joinTeam = result;
      update();
    }
  }

  callNextPage(Widget widget, context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }

  copyLink() async {
    if (myLeague.id != null) {
      await Clipboard.setData(ClipboardData(text: myLeague.id!));
      ToastService.showSuccess("Copied");
    } else {
      ToastService.showSuccess("No league");
    }
  }

  LeagueDetailModel league = LeagueDetailModel();

  getLeague() async {
    var id = leagues.first.id;
    leagueId = leagues.last.id ?? "";
    Logger().e("liga id :${leagues.last.id}}");
    try {
      var response = await DioService.dio
          .get<String>(DioService.LEAGUE_DETAIL_API + id.toString());
      if (response.statusCode == 200) {
        var result = leagueDetailModelFromJson(response.data!);
        league = result;
        print("liga name ;${league.name}");
        print("liga id ;${league.id}");
        print("liga img ;${league.image}");
        update();
      }
    } catch (e) {
      print("error hello $e");
    }
    update();
  }

  joinLeague(context) async {
    String? errorMessage = "";
    isJoin = false;
    var userId = DbService.getUserId();
    if (league.id != null) {
      try {
        var response = await DioService.dio
            .post(DioService.joinLeagueApi(league.id!, userId));

        if (response.statusCode == 200) {
          ToastService.showSuccess("Siz ligaga qo'shildingiz");
          isJoin = true;
        } else {
          errorMessage = response.statusMessage;
          Logger().e(errorMessage);
        }
      } on DioException catch (e) {
        if (e.response!.statusCode == 409) {
          ToastService.showError("Siz bu ligaga qo'shilgansiz");
        } else {
          ToastService.showError("Xatolik yuz berdi");
        }
      }
    }
  }
}
