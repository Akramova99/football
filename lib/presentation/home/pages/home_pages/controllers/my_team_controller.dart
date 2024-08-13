import 'package:get/get.dart';

import '../../../../../models/team_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';
import '../../../../../utils/constants/constants.dart';

class MyTeamController extends GetxController {
  String? teamName;

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
    team.players = fillTeamWithRequiredPositions(team.players!, getTactics());
    teamIcon = team.logo;
    isLoading = true;
    update();

    getPrimaryTeam();
    getReservePlayers(team.players!);
  }

  Map<String, int> getTactics() {
    var tatcic = tacticValues[team.tactic];
    Map<String, int> values = {
      'Goalkeeper'.toUpperCase(): tatcic![0],
      'Defender'.toUpperCase(): tatcic[1],
      'Midfielder'.toUpperCase(): tatcic[2],
      'Forward'.toUpperCase(): tatcic[3],
    };
    return values;
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
    print(player.position);
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
        print("teamid: ${team.id}");
        print("plare1: ${primaryTeam[i].id}");
        print("plare12: ${player.id}");
        if(primaryTeam[i].name != null){
          var result = await DioService.dio.post(
            DioService.changePlayer(team.id.toString(), primaryTeam[i].id, false),
          );
          print("removing player from primary team: ${result.data}");
        }



        var result2 = await DioService.dio
            .post(DioService.changePlayer(team.id.toString(), player.id, true));
        print("adding player from reserve: ${result2.data}");

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
