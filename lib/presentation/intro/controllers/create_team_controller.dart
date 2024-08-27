import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:football/models/player_selection_model.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

import '../../../models/club_model.dart';
import '../../../models/team_model.dart';
import '../../../services/db_service.dart';
import '../../../utils/converter.dart';

class CreateTeamController extends GetxController {
  List<PlayerSelectionModel> players = [];

  List<ClubModel> clubs = [];
  int clubsIndex = 0;
  List<Player> playersDetails = [];

  double minPrice = 0;
  double maxPrice = 10;

  bool isLoadingPLayer = false;

  double balance = 100;

  bool isTeamReady = true;

  autoFill() async {
    isTeamReady = false;
    update();
    try {
      var response =
          await DioService.dio.post<double>("/api/v1/teams/$teamId/auto-fill");
      if (response.statusCode == 200) {
        var budget = response.data!;
        balance = budget;
        DbService.saveBalance(balance);
        isTeamFool = 15;
        getTeam();
      }
    } on DioException catch (e) {
      ToastService.showError("Qayta urining");
    }
  }

  TeamModel team = TeamModel();
  String tactics = "";

  getTeam() async {
    var response = await DioService.GET(DioService.GET_TEAM_API + teamId, null);
    var myTeam = teamModelFromJson(response);
    print("tactics");
    print(myTeam.tactic ?? "");
    tactics = myTeam.tactic != null ? "${myTeam.tactic}" : "1-3-4-3";
    playersInField =
        convertPlayerListToPlayerSelectionModelList(myTeam.players!);
    isTeamReady = true;
    update();
  }

  searchPlayers(position) async {
    var path = clubsIndex != 0
        ? "/api/v1/players/filter?position=$position&minPrice=$minPrice&maxPrice=$maxPrice&clubId=${clubs[clubsIndex].id}"
        : "/api/v1/players/filter?position=$position&minPrice=$minPrice&maxPrice=$maxPrice";
    print(path);
    isLoadingPLayer = true;
    update();
    var response = await DioService.dio.get<String>(path);
    if (response.statusCode == 200) {
      print("Searching");
      var jsonData = (response.data!);
      var players = playerModelFromJson(jsonData);
      playersDetails = convertPlayerSelectionModelListToPlayerList(players);

      isLoadingPLayer = false;
      update();
    } else {
      print(response.statusMessage);
    }
  }

  List<PlayerSelectionModel> randomPlayers = [];



  List<PlayerSelectionModel> selectTeam(List<PlayerSelectionModel> players) {
    List<PlayerSelectionModel> selectedPlayers = [];
    double totalCost = 0;
    Map<String, int> clubCounts = {
      'goalkeeper': 0,
      'midfielder': 0,
      'defender': 0,
      'forward': 0,
    };

    // Separate players by position
    List<PlayerSelectionModel> goalkeepers = [];
    List<PlayerSelectionModel> midfielders = [];
    List<PlayerSelectionModel> defenders = [];
    List<PlayerSelectionModel> forwards = [];

    for (var player in players) {
      switch (player.position) {
        case 'goalkeeper':
          goalkeepers.add(player);
          break;
        case 'midfielder':
          midfielders.add(player);
          break;
        case 'defender':
          defenders.add(player);
          break;
        case 'forward':
          forwards.add(player);
          break;
      }
    }

    // Helper function to add a player to the team
    bool addPlayer(PlayerSelectionModel player) {
      if (totalCost + player.price! > 100 ||
          (clubCounts[player.clubName] ?? 0) >= 3) {
        return false;
      }
      selectedPlayers.add(player);
      totalCost += player.price!;
      clubCounts[player.clubName!] = (clubCounts[player.clubName] ?? 0) + 1;
      return true;
    }

    // Select 1 goalkeeper
    for (var goalkeeper in goalkeepers) {
      if (addPlayer(goalkeeper)) break;
    }

    // Select 4 midfielders
    int midfielderCount = 0;
    for (var midfielder in midfielders) {
      if (addPlayer(midfielder)) {
        midfielderCount++;
        if (midfielderCount == 4) break;
      }
    }

    // Select 3 defenders
    int defenderCount = 0;
    for (var defender in defenders) {
      if (addPlayer(defender)) {
        defenderCount++;
        if (defenderCount == 3) break;
      }
    }

    // Select 3 forwards
    int forwardCount = 0;
    for (var forward in forwards) {
      if (addPlayer(forward)) {
        forwardCount++;
        if (forwardCount == 3) break;
      }
    }

    // Reserve players: 1 for each position
    for (var goalkeeper in goalkeepers) {
      if (!selectedPlayers.contains(goalkeeper) && addPlayer(goalkeeper)) break;
    }
    for (var midfielder in midfielders) {
      if (!selectedPlayers.contains(midfielder) && addPlayer(midfielder)) break;
    }
    for (var defender in defenders) {
      if (!selectedPlayers.contains(defender) && addPlayer(defender)) break;
    }
    for (var forward in forwards) {
      if (!selectedPlayers.contains(forward) && addPlayer(forward)) break;
    }

    return selectedPlayers;
  }

  onPriceChange(index, min, max) {
    print(index);
    if (index == 0) minPrice = min;
    if (index == 1) maxPrice = max;
    update();
  }

  getClubs() async {
    var response = await DioService.GET(DioService.ALL_ClUBS, null);
    var clubList = clubModelFromJson(response);
    clubs.add(ClubModel());
    clubs.addAll(clubList);
    update();
  }

  onClubChange(int? index) {
    clubsIndex = index ?? 0;
    update();
    searchPlayers(previousPosition);
  }

  List<PlayerSelectionModel> playersInField = List.generate(
    15,
    (index) => PlayerSelectionModel(),
  );
  int tacticsIndex = 0;
  List<bool> chosen = List.generate(15, (_) => false);
  List<PlayerSelectionModel> selectivePlayer = [];

  int isTeamFool = 0;
  String teamId = '';

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

  saveGameTactics() {
    DbService.saveTactics(tactics);
  }

  String previousPosition = "";

  selectPlayer(String position, int index) {
    List<PlayerSelectionModel> list = [];
    chosen = List.generate(15, (_) => false); // Reset chosen list
    chosen[index] = true;

    for (var i = 0; i < players.length; i++) {
      if (players[i].position == position.toUpperCase()) {
        list.add(players[i]);
      }
    }

    //selectivePlayer.clear();
    selectivePlayer = list;
    update();
    if (position.toUpperCase() != previousPosition) {
      searchPlayers(position.toUpperCase());
    }
    previousPosition = position.toUpperCase();
  }

  assignPlayer(PlayerSelectionModel player) async {
    for (var i = 0; i < chosen.length; i++) {
      if (chosen[i]) {
        if (!playersInField.contains(player)) {
          String playerId = player.id.toString();
          try {
            var response = await DioService.dio.post(DioService.addPlayerAPI(
                teamId, playerId, isTeamFool >= 11 ? false : true));

            if (response.statusCode == 200) {
              playersInField[i] = player;
              selectivePlayer.remove(player);
              balance -= player.price!;
              players.remove(player);
              update();
              chosen[i] = false;
              isTeamFool++;
            } else {
              ToastService.showError(response.statusMessage ??
                  "Hatolik yuz berdi iltimos qayta uring");
            }
          } on DioException catch (e) {
            print(e.message);
            ToastService.showError("Iltimos boshqa oyinchi tanlang");
          }
        }
      }
    }
  }
}
