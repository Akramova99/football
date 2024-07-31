import 'package:get/get.dart';

import '../../../../../models/team_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';

class TransferPageController extends GetxController{
  String teamName = "";
  String? teamIcon;
  int points = 0;
  TeamModel team = TeamModel();
  bool isLoading = false;

  List<bool> chosen = List.generate(11, (_) => false);

  List<Player> reservePlayers = [];
  List<Player> primaryTeam = [];
  List<Player> selectivePlayers = [];

  getTeam() async {
    String userId = DbService.getUserId();
    var response =
    await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    var result = teamModelFromJson(response);
    team = result;
    teamName = team.name!;
    isLoading = true;
    update();

    getReservePlayers(team.players!);
  }

  getReservePlayers(List<Player> players) {
    List<Player> list = [];
    List<Player> list2 = [];
    for (var p in players) {
      if (!(p.isPrimary ?? false)) {
        list.add(p);
      } else {
        list2.add(p);
      }
    }
    primaryTeam = list2;
    reservePlayers = list;
    selectivePlayers = list;
    update();
  }

  selectPlayer(Player player) {
    print(player.name!);

    var index = primaryTeam.indexOf(player);
    List<Player> list = [];
    chosen = List.generate(11, (_) => false); // Reset chosen list
    chosen[index] = true;

    for (var i = 0; i < reservePlayers.length; i++) {
      if (reservePlayers[i].position == player.position) {
        list.add(reservePlayers[i]);
      }
    }
    selectivePlayers = list;
    update();
  }

  assignPlayer(Player player) {
    for (var i = 0; i < chosen.length; i++) {
      if (chosen[i]) {
        team.players![i] = player;
        update();
        chosen[i] = false;
        //addPlayer(player, true);
      }
    }
  }
}