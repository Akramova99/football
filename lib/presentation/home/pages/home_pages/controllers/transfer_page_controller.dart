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
import 'package:logger/web.dart';

import '../../../../../models/player_selection_model.dart';
import '../../../../../models/standing_model.dart';
import '../../../../../models/team_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';

class TransferPageController extends GetxController {
  String teamName = "";
  String? teamIcon;
  String? balance;
  int points = 0;
  TeamModel team = TeamModel();
  TransferSummaryModel transferSummaryModel =
      TransferSummaryModel(balance: 0.0);
  bool isLoading = false;
  bool isLoading2 = false;
  late String userId;

  List<bool> chosen = List.generate(15, (_) => false);

  List<bool> isExpandedList = List.generate(15, (_) => true);

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
  List<Team> standing = [];
  List<int> indexes = [];

  getTransferSummary() async {
    String userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.TRANSFER_SUMMARY + userId, null);
    transferSummaryModel = transferSummaryModelFromJson(response);
    Logger().i(transferSummaryModel.balance);
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

  getStanding() async {
    var response = await DioService.GET(DioService.STANDING_PLAYERS, null);
    standing = standingModelFromJson(response);
    //  Logger().i(standing[0].leagueId);
    update();
  }

  String previous = "Forward";

  onClubChange( String clubName) {
   // clubsIndex = index ?? 0;
    Logger().d(clubsIndex);

    // playersDetails ro'yxatini clubName asosida saralash
    playersDetails = playersDetails
        .where((player) => player.clubName!.contains(clubName))
        .toList();

    update();
  }


  Map<String, int> getTactics() {
    var tatcic = tacticValues[team.tactic];
    Map<String, int> values = {
      'Goalkeeper'.toUpperCase(): tatcic![0],
      'Defender'.toUpperCase(): tatcic[1],
      'Midfielder'.toUpperCase(): tatcic[2],
      'Forward'.toUpperCase(): tatcic[3]
    };
    return values;
  }

  getTeam() async {
    userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    Logger().i(response);
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
    // Reset chosen list
    Logger().i("select");
    if (isExpandedList[index]) {
      isExpandedList[index] = false;
    } else {
      isExpandedList[index] = true;
    }

    if (player.name == null) {
      if (chosen[index]) {
        chosen[index] = !chosen[index];
      } else {
        chosen = List.generate(15, (_) => false);
        chosen[index] = true;
      }
      previous = player.position!;
      searchPlayers2(player.position!);
      selectivePlayers.clear();
      playersDetails.clear();
    }
    update();
  }

  sellPLayer(Player player) async {
    // Logger().i("selling");

    int index = primaryTeam.indexOf(player);
    if (index != -1) {
      try {
        var response = await DioService.dio
            .post(DioService.sellPLayer(userId, team.id, player.id));

        if (response.statusCode == 200) {
          Logger().i(
              "player sold:\nposition:${player.position}\nis primary: ${player.isPrimary}\nindex$index");
          primaryTeam[index] =
              Player(position: player.position, isPrimary: player.isPrimary);
          indexes.add(index);
        }
        getTransferSummary();
        update();
      } on DioException catch (e) {
        if (e.response?.statusCode == 409) {
          ToastService.showError("Sizda tekin transfer yo'q");
        } else {
          ToastService.showError("Xatolik yuz berdi");
        }
      }
    }
  }

  buyPlayer(Player player) async {
    // Logger().e(chosen[i]);
    if (true) {
      isLoading2 = false;
      bool isPrimary = player.isPrimary ?? true;
      Logger().e(isPrimary);
      try {
        var response = await DioService.dio
            .post(DioService.buyPLayer(userId, team.id, player.id, isPrimary));
        Logger().i(
            "player bought\n userId:${userId}\nteam.id:${team.id}\nis player.id: ${player.id}\nis isPrimary: ${isPrimary}");
        if (response.statusCode == 200) {
          Logger().i(
              "player bought\n name:${player.name}\npostion:${player.position}\nis primary: $isPrimary");
          for (int item in indexes) {
            primaryTeam[item] = player;
            indexes.remove(item);
            break;
          }

          selectivePlayers.remove(player);
          // var response = await DioService.POST(
          //     DioService.buyPLayer(userId, team.id, player.id), null);
          // print(response);

          update();
          getTransferSummary();

          playerToBuy.remove(player);
          isLoading2 = true;
          ToastService.showSuccess("Sotib olindi");
          Logger().e("Sotib olindi");
        } else {
          Logger().e(response.statusMessage.toString());
        }
      } on Exception catch (e) {
        ToastService.showError("BUdget yetarli emas");
        Logger().e(e);
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

  // onPositionChange(index) {
  //   positionIndex = index;
  //   update();
  // }

  // onPointsChange(index) {
  //   pointsIndex = index;
  //   update();
  // }

  onPriceChange(index, min, max) {
    if (index == 0) minPrice = min;
    if (index == 1) maxPrice = max;
    update();
  }

  bool isLoadingPLayer = false;

  searchPlayers() async {
    for (int i = 0; i < 4; i++) {
      String position = listPositionHeader[i].toUpperCase();
      var path = clubsIndex != 0
          ? "/api/v1/players/filter?position=$position&minPrice=$minPrice&maxPrice=$maxPrice&clubId=${clubs[clubsIndex].id}"
          : "/api/v1/players/filter?position=$position&minPrice=$minPrice&maxPrice=$maxPrice";
      // print(path);
      isLoadingPLayer = true;
      update();
      try {
        var response = await DioService.dio.get<String>(path);
        Logger().w(response.statusCode);
        if (response.statusCode == 200) {
          print("Searching");
          var jsonData = (response.data!);
          var players = playerModelFromJson(jsonData);
          playersDetails
              .addAll(convertPlayerSelectionModelListToPlayerList(players));
          selectivePlayers = playersDetails;
          isLoadingPLayer = false;
          update();
        } else {
          print(response.statusMessage);
        }
      } on DioException catch (e) {
        Logger().e(e);
      }
    }
  }

  searchPlayers2(String position) async {
    for (int i = 0; i < 4; i++) {
      String position = listPositionHeader[i];
      var path = clubsIndex != 0
          ? "/api/v1/players/filter?position=$position&minPrice=$minPrice&maxPrice=$maxPrice&clubId=${clubs[clubsIndex].id}"
          : "/api/v1/players/filter?position=$position&minPrice=$minPrice&maxPrice=$maxPrice";
      // print(path);
      isLoadingPLayer = true;
      update();
      try {
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
      } on DioException catch (e) {
        Logger().e(e);
      }
    }
  }

  goToBalancePage(context) {
    Navigator.pop(context);
    Get.find<BasePageController>().onBottomNavItemClick(2);
  }
}
