import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:football/models/club_model.dart';
import 'package:football/models/match_model.dart';
import 'package:football/models/transfer_summary_model.dart';
import 'package:football/presentation/home/controllers/base_page_controller.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/utils/constants/constants.dart';
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
  TransferSummaryModel transferSummaryModel = TransferSummaryModel();
  bool isLoading = false;
  late String userId;
  List<bool> chosen = List.generate(15, (_) => false);
  List<ClubModel> clubs = [];

  List<Player> playerToBuy = [];
  List<Player> primaryTeam = List.generate(
    16,
    (index) => Player(),
  );
  List<Player> selectivePlayers = [];
  List<Player> playersDetails = [];
  int clubsIndex = 0;

  String deadline = "";
  MatchWeek matchWeek = MatchWeek();

  getTransferSummary() async {
    var response =
        await DioService.GET(DioService.TRANSFER_SUMMARY + userId, null);
    transferSummaryModel = transferSummaryModelFromJson(response);

    var _deadline =
        await DioService.dio.get<String>("/api/calendars/get-start-match-week");
    if (_deadline.statusCode == 200) {
      if (_deadline.data != null) {
        deadline = _deadline.data!;
      }
    }

    var _matchWeek =
        await DioService.dio.get<String>(DioService.CURRENT_MATCHWEEK);
    if (_matchWeek.statusCode == 200) {
      if (_matchWeek.data != null) {
        matchWeek = MatchWeek.fromJson(jsonDecode(_matchWeek.data!));
      }
    }
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

  getTeam() async {
    userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    var result = teamModelFromJson(response);
    team = result;
    primaryTeam = fillTeamWithRequiredPositions(team.players!, getTactics());
    getPLayers();
    teamName = team.name!;
    teamIcon = team.logo;
    isLoading = true;
    selectivePlayers = playerToBuy;
    print(team.tactic);
    update();
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

  selectPlayer(Player player) {
    var index = primaryTeam.indexOf(player);
    List<Player> list = [];
    if (chosen[index]) {
      chosen[index] = !chosen[index];
    } else {
      chosen = List.generate(15, (_) => false);
      chosen[index] = true;
    } // Reset chosen list

    // for (var i = 0; i < playerToBuy.length; i++) {
    //   if (playerToBuy[i].position == player.position) {
    //     list.add(playerToBuy[i]);
    //   }
    // }
    if (player.name == null) {
      print("\nposition:${player.position}\nis primary: ${player.isPrimary}");
      searchPlayers(player.position);
      selectivePlayers = list;
      playersDetails = list;
    }
    update();
  }

  sellPLayer(Player player) async {
    print("selling");
    var index = primaryTeam.indexOf(player);
    if (index != -1) {
      try {
        var response = await DioService.dio
            .post(DioService.sellPLayer(userId, team.id, player.id));

        if (response.statusCode == 200) {
          print(
              "player sold:\nposition:${player.position}\nis primary: ${player.isPrimary}");
          primaryTeam[index] =
              Player(position: player.position, isPrimary: player.isPrimary);
        }
        getTransferSummary();
        update();
      } on DioException catch (e) {
        if (e.response?.statusCode == 400) {
          ToastService.showError("Sizda tekin transfer yo'q");
        } else {
          ToastService.showError("Xatolik yuz berdi");
        }
      }
    }
  }

  buyPlayer(Player player) async {
    for (var i = 0; i < chosen.length; i++) {
      if (chosen[i]) {
        bool isPrimary = primaryTeam[i].isPrimary!;
        try {
          var response = await DioService.dio.post(
              DioService.buyPLayer(userId, team.id, player.id, isPrimary));

          if (response.statusCode == 200) {
            print(
                "player bought\n name:${player.name}\npostion:${player.position}\nis primary: $isPrimary");
            primaryTeam[i] = player;
            print(primaryTeam[i].name);
            selectivePlayers.remove(player);
            // var response = await DioService.POST(
            //     DioService.buyPLayer(userId, team.id, player.id), null);
            // print(response);

            update();
            getTransferSummary();
            chosen[i] = false;
            playerToBuy.remove(player);
          } else {
            print(response.statusMessage);
          }
        } on Exception catch (e) {}
        ToastService.showError("Xatolik");
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
    if (index == 0) minPrice = min;
    if (index == 1) maxPrice = max;
    update();
  }

  bool isLoadingPLayer = false;

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
      selectivePlayers = playersDetails;
      isLoadingPLayer = false;
      update();
    } else {
      print(response.statusMessage);
    }
  }

  goToBalancePage(context) {
    Navigator.pop(context);
    Get.find<BasePageController>().onBottomNavItemClick(1);
  }
}
