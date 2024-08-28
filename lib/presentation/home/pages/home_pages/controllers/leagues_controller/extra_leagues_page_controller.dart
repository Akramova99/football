import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football/services/db_service.dart';
import 'package:get/get.dart';

import '../../../../../../models/league_detail_model.dart';
import '../../../../../../models/league_model.dart';
import '../../../../../../services/dio_service.dart';
import '../../../../../widgets/toast.dart';

class ExtraLeaguesPageController extends GetxController {
  List<LeagueModel> leagues = [];
  var userId = DbService.getUserId();

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

  LeagueModel myLeague = LeagueModel();

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

  callNextPage(Widget widget, context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }

  copyLink() async {
    await Clipboard.setData(ClipboardData(text: myLeague.id ?? ""));
    ToastService.showSuccess("Copied");
  }

  LeagueDetailModel league = LeagueDetailModel();

  getLeague() async {
    var id = leagues.first.id;
    print("liga id :$id}");
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
    var userId = DbService.getUserId();
    if (league.id != null) {
      try {
        var response = await DioService.dio
            .post(DioService.joinLeagueApi(league.id!, userId));

        if (response.statusCode == 200) {
          ToastService.showSuccess("Siz ligaga qo'shildingiz");
        } else {
          errorMessage = response.statusMessage;
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
