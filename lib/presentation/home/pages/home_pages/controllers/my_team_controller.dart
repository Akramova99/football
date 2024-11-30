import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../../../models/team_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';
import '../../../../../utils/constants/constants.dart';

class MyTeamController extends GetxController {
  String? teamName;
  int tacticsIndex = 0;
  String? teamIcon;
  int points = 0;
  TeamModel team = TeamModel();
  bool isLoading = false;
  bool isOne = false;
  bool isUsing = false;

  List<bool> chosen = List.generate(11, (_) => false);
  List<Player> sortedList = [];
  List<Player> usedPlayers = [];
  List<Player> primaryTeam = [];
  List<Player> selectivePlayers = [];
  List<Player> newPlayers = [];
  List<Player> withoutFiledPlayers = [];
  int selectivePlayerId = 0;

  onTacticsChange(index) {
    tacticsIndex = index;
    index == 1 || index == 2 || index == 5 || index == 6 || index == 7
        ? isOne = true
        : false;
    changeTactic();
    update();
  }

  checkTactics(index) {
    index == 1 || index == 2 || index == 5 || index == 6 || index == 7
        ? isOne = true
        : false;
  }

  changeTactic() async {
    await DioService.dio.post(
        "/api/v1/teams/${team.id}/set-tactic/${tacticsString[tacticsIndex]}",
        data: {});
  }

  List<Player> _previousPlayers = [];

  Future<void> getTeam() async {
    isLoading = false;
    String userId = DbService.getUserId();

    var response =
        await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    var result = teamModelFromJson(response);
    team = result;

    teamName = team.name!;
    team.players = fillTeamWithRequiredPositions(
        _syncPlayerList(result.players!), getTactics());

    log("team_players: ${team.players} length:  ${team.players!.length}");

    teamIcon = team.logo;
    isLoading = true;
    update();

    getPrimaryTeam();
    getReservePlayers(team.players!);
  }

  List<Player> _syncPlayerList(List<Player> newPlayers) {
    // Agar eski player list bo'sh bo'lsa, yangi playerlarni to'g'ridan-to'g'ri qo'sh
    if (_previousPlayers.isEmpty) {
      _previousPlayers = List.from(newPlayers); // Eski holatni saqlab qo'yish
      return newPlayers;
    }

    // Eski listni o'zgartirish uchun yangi list asosida ishlov beramiz
    List<Player> updatedPlayers = List.from(_previousPlayers);

    for (var newPlayer in newPlayers) {
      // Eski listda yangi playerni qidiramiz
      int index =
          updatedPlayers.indexWhere((player) => player.id == newPlayer.id);

      if (index != -1) {
        // Player topilsa, o'sha joyni yangilash
        updatedPlayers[index] = newPlayer;
      } else {
        // Agar yangi player bo'lsa, oxiriga qo'shish
        updatedPlayers.add(newPlayer);
      }
    }

    // Eski listni yangilash
    _previousPlayers = List.from(updatedPlayers);

    return updatedPlayers;
  }

  changeCapitan(int playerId) async {
    //isLoading = false;
    String userId = DbService.getUserId();

    var response =
        await DioService.GET(DioService.GET_MYTEAM_API + userId, null);
    var result = teamModelFromJson(response);

    var teamId = result.id;
    var capitanResponse = await DioService.POST(
        "${DioService.ASSIGN_CAPITAN}$teamId/$playerId", null);

    ToastService.showSuccess("Capitan change successfully");
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
    log("Ishlaydi hoz");
    List<Player> list = [];

    for (var p in players) {
      if ((p.isPrimary ?? true) == false) {
        list.add(p);
      }
    }
    log(list.length.toString() + " dhjbs");

    selectivePlayers = list;
    withoutFiledPlayers = selectivePlayers;
    log(selectivePlayers.length.toString() + " dhjbs");
    update();
  }

  getPrimaryTeam() {
    Logger().i("getPrimaryTeam");
    primaryTeam.clear();
    for (var player in team.players!) {
      if (player.isPrimary == true) {
        primaryTeam.add(player);
      }
    }
    // Logger().i("Used player");
    // Logger().i(usedPlayers.length);
    // for (final player in usedPlayers) {
    //   log(player.name.toString());
    // }
    Logger().w(primaryTeam.length);
  }

  selectPlayer(Player player, {void Function()? onSelectedPlayer}) {
    log("Ishlaydi hoz");
    int index = primaryTeam.indexOf(player);
    if (index == -1) {
      return;
    }

    List<Player> list = [];
    chosen = List.generate(11, (_) => false); // Reset chosen list
    chosen[index] = true;

    // for (var i = 0; i < reservePlayers.length; i++) {
    //   if (reservePlayers[i].position == player.position) {
    //     list.add(reservePlayers[i]);
    //   }
    // }
    selectivePlayers = list;
    update(); // Update the UI
  }

  selectPlayer1(Player player, {BuildContext? context}) async {
    selectivePlayerId = player.id!;

    try {
      isUsing = true;

      // withoutFiledPlayers ro'yxatini boshlang'ich qiymat bilan cheklaymiz
      if (withoutFiledPlayers.length == 4) {
        sortedList = withoutFiledPlayers.take(4).toList();
      }

      log("Boshlang'ich withoutFiledPlayers: ${withoutFiledPlayers.length} ta o'yinchi");

      // Yangi vaqtinchalik ro'yxat
      List<Player> list = [];

      // withoutFiledPlayers ro'yxatidan filterlash
      for (final myPlayer in sortedList) {
        if (myPlayer.position == player.position) {
          log("${myPlayer.name} myplayer");
          list.add(myPlayer);
        }
      }

      // `list`ni tekshirib, `withoutFiledPlayers`ni yangilash
      if (list.isEmpty) {
        withoutFiledPlayers = []; // Bo'sh ro'yxat
        log("withoutFiledPlayers bo'sh");
      } else {
        withoutFiledPlayers = list; // Filtrlangan ro'yxat
        log("Yangi withoutFiledPlayers: ${withoutFiledPlayers.length} ta element");
      }

      update(['withoutFiledPlayers']); // Yangilanishni chaqirish
      isUsing = false;
    } on DioException catch (errorResponse, st) {
      log("selectPlayer1: ", stackTrace: st);
      log("${errorResponse.response}");
      log("${errorResponse.response?.statusCode}");
      log("${errorResponse.response?.data}");
      closeDialog(context);
    }
  }

  changeReserve(Player player, dynamic teamId) async {
    if ((player.isPrimary ?? true) == false) {
      try {
        //  print(player.toJson());
        await DioService.dio.post(
          DioService.changePlayer(teamId.toString(), player.id, true),
        );

        Logger().i(player.isPrimary);
      } on DioException catch (e) {
        print(e.response);
        print(e);
      }
    }
  }

  assignPlayer(Player player, {BuildContext? context}) async {
    if (team.id != null) {
      showLoadingDialog(context);
      try {
        // log(team.id.toString());
        // log(selectivePlayerId.toString());
        // log(player.id.toString());
        await DioService.dio
            .put(
                "/api/v1/teams/${team.id}/switch-primary?oldPrimaryPlayerId=$selectivePlayerId&newPrimaryPlayerId=${player.id}")
            .then((value) {
          // log("$value++++++++++++++++++++++++++++++");
          getTeam();
          closeDialog(context);
        });
      } catch (e) {
        closeDialog(context);
      }
    }
  }

  void changePlayersStatus() async {
    for (var myPlayer in usedPlayers) {
      log("${myPlayer.isPrimary} ${myPlayer.id} ${myPlayer.position} ${myPlayer.name}   usedPlayers");
    }
    final unprocessedPlayers = team.players!.where((player) =>
        player.id != null &&
        !usedPlayers.contains(player) &&
        player.isPrimary == true);

    for (final player in unprocessedPlayers) {
      try {
        final response = await DioService.dio.post(
          DioService.changePlayer(team.id.toString(), player.id, false),
        );
        log("changePlayersStatus: false${response.data} ${response.statusCode}");
        getPrimaryTeam();
      } on DioException catch (error, stackTrace) {
        log("changePlayersStatus: ${error.response?.data}",
            error: error, stackTrace: stackTrace);
      }
    }

    for (final player in usedPlayers) {
      if (player.id == null) continue;
      try {
        if (!(player.isPrimary ?? true)) {
          await DioService.dio
              .post(
            DioService.changePlayer(team.id.toString(), player.id, true),
          )
              .then((value) {
            log("changePlayersStatus true: ${value.data} ${value.statusCode}");
          });
        }
      } on DioException catch (error, stackTrace) {
        log("changePlayersStatus: ${error.response?.data}",
            error: error, stackTrace: stackTrace);
      }
    }
  }

  void changeSelectivePlayers() {
    log("Ishlaydi hoz changeSelectivePlayers");
    withoutFiledPlayers =
        team.players!.where((player) => !usedPlayers.contains(player)).toList();
    //  getTeam();
  }
}

void showLoadingDialog(BuildContext? context) {
  if (context != null) {
    showDialog(
      context: context,
      builder: (context) {
        return const SizedBox(
          height: 40,
          width: 40,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

void closeDialog(BuildContext? context) {
  if (context != null) Navigator.pop(context);
}
