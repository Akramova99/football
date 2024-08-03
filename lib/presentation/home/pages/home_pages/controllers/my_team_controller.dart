import 'package:get/get.dart';

import '../../../../../models/team_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';

class MyTeamController extends GetxController {
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
    isLoading = false;
    String userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    var result = teamModelFromJson(response);
    team = result;
    teamName = team.name!;
    isLoading = true;
    update();

    getPrimaryTeam();
    //addPlayer();
    getReservePlayers(team.players!);
  }

  getReservePlayers(List<Player> players) {
    List<Player> list = [];
    for (var p in players) {
      if (!(p.isPrimary ?? false)) {
        list.add(p);
      }
    }
    reservePlayers = list;
    selectivePlayers = list;
    update();
  }

  getPrimaryTeam() {
    for (var player in team.players!) {
      if (player.isPrimary ?? false) {
        primaryTeam.add(player);
      }
    }
  }

  addPlayer() {
    for (var player in reservePlayers) {
      if (player.position == "DEFENDER") {
        primaryTeam.add(player);
        DioService.POST(
            DioService.changePlayer(team.id.toString(), player.id, true), null);
        return;
      }
    }
    print(("reserve players"));
  }

  selectPlayer(Player player) {
    int index = primaryTeam.indexOf(player);
    if (index == -1) {
      print("Player not found in primary team");
      return;
    }

    List<Player> list = [];
    chosen = List.generate(11, (_) => false); // Reset chosen list
    chosen[index] = true;

    for (var i = 0; i < reservePlayers.length; i++) {
      if (reservePlayers[i].position == player.position) {
        list.add(reservePlayers[i]);
      }
    }
    selectivePlayers = list;
    update(); // Update the UI
  }

  assignPlayer(Player player) async {
    for (var i = 0; i < chosen.length; i++) {
      if (chosen[i]) {
        print(team.id);

        await DioService.POST(
            DioService.changePlayer(
                team.id.toString(), primaryTeam[i].id, false),
            null);

        await DioService.POST(
            DioService.changePlayer(team.id.toString(), player.id, true), null);


        selectivePlayers.remove(player);
        reservePlayers.remove(player);

        Player temp = primaryTeam[i];

        player.isPrimary = true;
        primaryTeam[i] = player;
        temp.isPrimary = false;

        selectivePlayers.add(temp);
        reservePlayers.add(temp);

        player = temp;

        print(selectivePlayers.contains(temp));
        print(primaryTeam.contains(player));

        update(); // Update the UI
        break; // Exit the loop after successful change
      }
    }
  }

  assignPlayer2(Player player) {
    for (var i = 0; i < chosen.length; i++) {
      if (chosen[i]) {
        Player temp = primaryTeam[i];

        player.isPrimary = true;
        primaryTeam[i].isPrimary = false;

        primaryTeam[i] = player;
        player = temp;

        DioService.POST(
            DioService.changePlayer(team.id.toString(), temp.id, false), null);
        DioService.POST(
            DioService.changePlayer(team.id.toString(), player.id, true), null);
        update(); // Update the UI
        break; // Exit the loop after successful change
      }
    }
  }
}
