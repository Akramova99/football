import 'package:flutter/services.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../models/league_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';

class InviteFriendsController extends GetxController {
  String? leaguePassword;
  String? leagueLink;
  var userId = DbService.getUserId();

  getData() {
    leaguePassword = "61DWKPEX03";
    leagueLink = "https://translate.google..";
  }

  share() async {
    await Share.share('check out my website https://example.com',
        subject: 'Look what I made!');
  }

  copyText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ToastService.showSuccess("Copied");
  }

  LeagueModel myLeague = LeagueModel();

  getMyLeagues() async {
    var response = await DioService.dio
        .get<String>("/api/v1/users/myLeagues?userId=$userId");
    if (response.statusCode == 200) {
      var result = leagueModelFromJson(response.data!);
      myLeague = result.last;
      leagueLink = myLeague.id!;
      update();
    }
  }
}
