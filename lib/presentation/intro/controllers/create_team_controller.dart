import 'package:flutter/cupertino.dart';
import 'package:football/models/player_selection_model.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/services/dio_service.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:get/get.dart';

import '../../../services/db_service.dart';

class CreateTeamController extends GetxController {
  List<PlayerSelectionModel> players = [];
  List<PlayerSelectionModel> playersInField = List.generate(
    15,
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
    playersInField = List.generate(
      16,
      (index) => PlayerSelectionModel(),
    );
    isTeamFool = 0;
    update();
  }

  saveGameTactics() {
    DbService.saveTactics(tacticsString[tacticsIndex]);
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

    //selectivePlayer.clear();
    selectivePlayer = list;
    update();
  }

  assignPlayer(PlayerSelectionModel player) async {
    for (var i = 0; i < chosen.length; i++) {
      if (chosen[i]) {
        if (!playersInField.contains(player)) {
          String playerId = player.id.toString();
          try {
            var response = await DioService.dio
                .post(DioService.addPlayerAPI(teamId, playerId, true));

            if (response.statusCode == 200) {
              playersInField[i] = player;
              selectivePlayer.remove(player);
              players.remove(player);
              update();
              chosen[i] = false;
              isTeamFool++;
            } else {
              ToastService.showError(response.statusMessage ??
                  "Hatolik yuz berdi iltimos qayta uring");
            }
          } on Exception catch (e) {
            ToastService.showError("Iltimos boshqa oyinchi tanlang");
          }
        }
      }
    }
  }

  //to get players at a random position
  addPlayer(PlayerSelectionModel player, bool isPrimary) {
    String playerId = player.id.toString();
    DioService.POST(DioService.addPlayerAPI(teamId, playerId, isPrimary), null);
  }

  assignReservePlayers() {
    int number = 0;

    // Create lists for each position
    List<PlayerSelectionModel> goalkeepers = [];
    List<PlayerSelectionModel> defenders = [];
    List<PlayerSelectionModel> midfielders = [];
    List<PlayerSelectionModel> forwards = [];

    // Sort players into position lists
    for (var player in players) {
      if (!playersInField.contains(player)) {
        switch (player.position) {
          case 'GOALKEEPER':
            goalkeepers.add(player);
            break;
          case 'DEFENDER':
            defenders.add(player);
            break;
          case 'MIDFIELDER':
            midfielders.add(player);
            break;
          case 'FORWARD':
            forwards.add(player);
            break;
        }
      }
    }

    // Helper function to add players from a specific list
    void addPlayersFromList(
        List<PlayerSelectionModel> positionList, int maxCount) {
      int count = 0;
      for (var player in positionList) {
        if (number < 4 && count < maxCount) {
          addPlayer(player, false);
          print(player.name);
          number++;
          count++;
        }
      }
    }

    // Add at least one player from each position
    addPlayersFromList(goalkeepers, 1);
    addPlayersFromList(defenders, 1);
    addPlayersFromList(midfielders, 1);
    addPlayersFromList(forwards, 1);

    // If less than 5 players added, fill the rest from any position
  }
}
