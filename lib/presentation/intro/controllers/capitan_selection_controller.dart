import 'package:flutter/cupertino.dart';
import 'package:football/models/team_model.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class CapitanSelectionController extends GetxController {
  List<Player> players = [];
  bool isDataReady = false;
  String? teamId;
  Player? capitan;

  getTeamId() async {
    teamId = DbService.getTeamId();
  }

  getTeam() async {
    await getTeamId();
    if (teamId != null) {
      var response =
          await DioService.GET(DioService.GET_TEAM_API + teamId!, null);
      var myTeam = teamModelFromJson(response);
      players = myTeam.players!;
      isDataReady = true;
      update();
    }
  }

  selectPlayer(Player player) {
    if (player.isPrimary!) {
      capitan = player;
      for (var p in players) {
        p.isCapitan = false;
      }
      player.isCapitan = true;

      update();
    } else {
      ToastService.showError("Siz zahiradagi o'yinchini tanladingiz");
    }

  }

  saveCapitan(PageController pageController) {
    int playerId = capitan!.id!;
    DioService.POST("${DioService.SELECT_CAPTAIN_API}/$teamId/$playerId", null);
    pageController.animateToPage(6,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInSine);
  }
}
