import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/league_detail_page.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../../../../models/league_model.dart';
import '../../pages/leagues/my_leagues.dart';

class LeaguesPageController extends GetxController {
  List<LeagueModel> leagues = [];

  getLeagues() async {
    // Get the logged-in user's ID
    var userId = DbService.getUserId();
    Logger().e("Fetching leagues for userId: $userId");

    try {
      // Fetch leagues from the API using the userId as a query parameter
      var response = await DioService.dio.get<String>(DioService.MY_LEAUGE,
          queryParameters: {"userId": userId});

      if (response.statusCode == 200) {
        var list = leagueModelFromJson(response.data!);
        leagues = list;
        update(); // Update UI
      }
    } on Exception catch (e) {
      print("$e");
    }
  }

  deleteLeague() async {
    var userId = DbService.getUserId();

    var response = await DioService.DELETE("/api/v1/leagues/$userId", null);

    if (response == "") {
      // Liga muvaffaqiyatli o'chirilgan

      print("Liga muvaffaqiyatli o'chirildi");
    } else {
      // Xatolik yuz berdi
      print("Xatolik: $response");
    }
  }

  callLeagueDetai(LeagueModel league, context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return LeagueDetailPage(id: league.id!);
    }));
  }

  callLeagueDetail(LeagueModel league, context, name) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MyLeagues(
        leagueId: league.id ?? "",
      );
    }));
  }

  callNextPage(Widget widget, context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
    getLeagues(); // Refresh leagues after returning from next page
  }
}
