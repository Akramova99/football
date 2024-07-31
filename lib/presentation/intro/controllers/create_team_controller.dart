import 'package:flutter/cupertino.dart';
import 'package:football/models/player_selection_model.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

import '../../../services/db_service.dart';

class CreateTeamController extends GetxController {
  List<PlayerSelectionModel> players = [];
  List<PlayerSelectionModel> playersInField = List.generate(
    16,
    (index) => PlayerSelectionModel(),
  );
  int tacticsIndex = 0;
  List<bool> chosen = List.generate(11, (_) => false);
  List<PlayerSelectionModel> selectivePlayer = [];
  Map<int, String> reversePosition = {
    0: "goalkeeper",
    1: "defender",
    2: "midfielder",
    3: "forward",
  };
  int isTeamFool = 0;
  String teamId = '';

  getPlayer() async {
    var response = await DioService.GET(DioService.RANDOM_PLAYERS_API, null);
    players = playerModelFromJson(response);
    selectivePlayer = players;
    update();
  }

  createTeam() async {
    var response = await DioService.POST(DioService.CREATE_TEAM_API, null);
    teamId = response;
    print(response + " create team");
  }

  saveTeamId() async {
    await DbService.saveTeamId(teamId);
    print("team id saved");
  }

  goToNextPage(PageController controller) {
    controller.animateToPage(4,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }

  onTacticsChange(index) {
    tacticsIndex = index;
    update();
  }

  selectPlayer(String position, int index) {
    print(position);
    List<PlayerSelectionModel> list = [];
    chosen = List.generate(11, (_) => false); // Reset chosen list
    chosen[index] = true;

    for (var i = 0; i < players.length; i++) {
      if (players[i].position == position.toUpperCase()) {
        list.add(players[i]);
      }
    }
    selectivePlayer = list;
    update();
  }

  assignPlayer(PlayerSelectionModel player) {
    for (var i = 0; i < chosen.length; i++) {
      if (chosen[i]) {
        if (!playersInField.contains(player)) {
          playersInField[i] = player;
          update();
          chosen[i] = false;
          isTeamFool++;
          addPlayer(player, true);
        }
      }
    }
  }

  assignReservePlayers() {
    int number = 0;

    for (var player in players) {
      if (!playersInField.contains(player) && number < 5) {
        addPlayer(player, false);
        print(player.name);
        number++;
      }
    }
  }

  addPlayer(PlayerSelectionModel player, bool isPrimary) {
    String playerId = player.id.toString();
    DioService.POST(DioService.addPlayerAPI(teamId, playerId, isPrimary), null);
  }
}
