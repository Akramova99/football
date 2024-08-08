import 'package:dio/dio.dart';
import 'package:football/models/user_data_model.dart';
import 'package:football/utils/converter.dart';
import 'package:get/get.dart';

import '../../../../../models/player_selection_model.dart';
import '../../../../../models/team_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';

class TransferPageController extends GetxController {
  String teamName = "";
  String? teamIcon;
  String? balance;
  int points = 0;
  TeamModel team = TeamModel();
  bool isLoading = false;
  late String userId;
  List<bool> chosen = List.generate(16, (_) => false);

  List<Player> playerToBuy = [];
  List<Player> primaryTeam = List.generate(
    11,
    (index) => Player(),
  );
  List<Player> selectivePlayers = [];
  List<Player> playersDetails = [];

  int transferCount = 0;

  getBalance() async {
    var response =
        await DioService.GET(DioService.USER_DATA_API + userId, null);
    var userData = userModelFromJson(response);
    balance = userData.balance.toString();
  }

  getTeam() async {
    userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    var result = teamModelFromJson(response);
    team = result;
    getPLayers();
    teamName = team.name!;
    teamIcon = team.logo;
    isLoading = true;
    selectivePlayers = playerToBuy;
    update();

    getPrimaryTeam(team.players!);
  }

  getPLayers() async {
    var response = await DioService.GET(DioService.RANDOM_PLAYERS_API, null);
    var players = playerModelFromJson(response);
    print(players[0].name);
    playerToBuy = combinePlayers(team.players!, players);
    print(selectivePlayers.length);
    selectivePlayers = playerToBuy;
    update();
  }

  getPrimaryTeam(List<Player> players) {
    List<Player> list2 = [];
    for (var p in players) {
      if ((p.isPrimary ?? false)) {
        list2.add(p);
      }
    }
    primaryTeam = list2;
    update();
  }

  selectPlayer(Player player) {
    var index = primaryTeam.indexOf(player);
    List<Player> list = [];
    if (chosen[index]) {
      chosen[index] = !chosen[index];
    } else {
      chosen = List.generate(11, (_) => false);
      chosen[index] = true;
    } // Reset chosen list

    for (var i = 0; i < playerToBuy.length; i++) {
      if (playerToBuy[i].position == player.position) {
        list.add(playerToBuy[i]);
      }
    }
    if (player.name == null) {
      selectivePlayers = list;
    }
    update();
  }

  sellPLayer(Player player) async {
    var index = primaryTeam.indexOf(player);
    if (index != -1) {
      primaryTeam[index] = Player(position: player.position, isPrimary: true);

      var response = await DioService.POST(
          DioService.sellPLayer(userId, team.id, player.id), null);
      print("$response");
      getBalance();
      update();

      transferCount++;
    }
  }

  assignPlayer(Player player) async {
    for (var i = 0; i < chosen.length; i++) {
      if (chosen[i]) {
        player.isPrimary = true;
        primaryTeam[i] = player;
        print(primaryTeam[i].name);
        selectivePlayers.remove(player);
        var response = await DioService.POST(
            DioService.buyPLayer(userId, team.id, player.id), null);
        print(response);
        getBalance();
        update();
        chosen[i] = false;
        playerToBuy.remove(player);
        //addPlayer(player, true);
      }
    }
  }

  double minPrice = 0;
  double maxPrice = 10;
  int positionIndex = 0;

  var listPosition = [
    'Hujumchi',
    'Yarim Himoyachi',
    'Himoyachi',
    'Darvozabon',
  ];

  var listPositionHeader = ["forward", "midfielder", "defender", "goalkeeper"];
  int pointsIndex = 0;
  var listPoints = ['Hamma Ochko', 'Hozirgi ochko'];
  var sortListen = ["total", "current"];

  onPositionChange(index) {
    positionIndex = index;
    update();
  }

  onPointsChange(index) {
    pointsIndex = index;
    update();
  }

  onPriceChange(index, min, max) {
    print(index);
    if (index == 0) minPrice = min / 10;
    if (index == 1) maxPrice = max / 10;
    update();
  }

  bool isLoadingPLayer = false;

  searchPlayers() async {
    isLoadingPLayer = true;
    update();
    var response = await DioService.dio.get<String>(DioService.PLAYER_FILTER,
        options: Options(headers: {
          "position": listPositionHeader[positionIndex].toUpperCase(),
          "minPrice": minPrice,
          "maxPrice": maxPrice,
          "sortBy": sortListen[pointsIndex]
        }));
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
}
