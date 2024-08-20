import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football/services/db_service.dart';
import 'package:get/get.dart';

import '../../../../../../models/league_model.dart';
import '../../../../../../services/dio_service.dart';
import '../../../../../widgets/toast.dart';
import '../../pages/leagues/league_detail_page.dart';

class ExtraLeaguesPageController extends GetxController {
  List<LeagueModel> leagues = [];
  var userId = DbService.getUserId();

  getLeagues() async {
    print(userId);
    try {
      var response = await DioService.dio
          .get<String>(DioService.LEAGUE_EXTRA_API + userId);
      if (response.statusCode == 200) {
        var list = leagueModelFromJson(response.data!);
        leagues = list;

        // if (leagues.isEmpty) {
        //   leagues = generateRandomLeagues(10);
        // }
        update();
      }
    } on Exception catch (e) {
      print("$e");
    }
  }

  LeagueModel myLeague = LeagueModel();

  getMyLeagues() async {
    var response = await DioService.dio
        .get<String>("/api/v1/users/myLeagues?userId=$userId");
    if (response.statusCode == 200) {
      var result = leagueModelFromJson(response.data!);
      myLeague = result.last;
      update();
    }
  }

  callLeagueDetail(LeagueModel league, context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return LeagueDetailPage(id: league.id!);
    }));
  }

  callNextPage(Widget widget, context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }

  copyLink() async {
    await Clipboard.setData(ClipboardData(text: myLeague.id ?? ""));
    ToastService.showSuccess("Copied");
  }
}
