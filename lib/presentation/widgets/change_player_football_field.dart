import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/my_team_controller.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:football/presentation/widgets/player_selection_widget.dart';
import 'package:football/presentation/widgets/players_card_widget.dart';
import 'package:football/presentation/widgets/tactics_menu_button.dart';
import 'package:get/get.dart';

import '../../models/team_model.dart';
import '../../utils/constants/constants.dart';
import '../home/pages/home_pages/pages/players_places.dart';

getTeamPLayers(List<Player> players, bool isTransferPage) {
  List<Player> primaryTeam = List.generate(
    16,
    (index) => Player(),
  );

  Map<String, int> tactic = {
    "GOALKEEPER": 0,
    "DEFENDER": 0,
    "MIDFIELDER": 0,
    "FORWARD": 0,
  };

  List<Player> list = List.generate(
    16,
    (index) => Player(),
  );

  for (var i = 0; i < players.length; i++) {
    if (isTransferPage) {
      switch (players[i].position) {
        case "MIDFIELDER":
          tactic["MIDFIELDER"] = tactic["MIDFIELDER"]! + 1;
          break;
        case "GOALKEEPER":
          tactic["GOALKEEPER"] = tactic["GOALKEEPER"]! + 1;
          break;
        case "DEFENDER":
          tactic["DEFENDER"] = tactic["DEFENDER"]! + 1;
          break;
        case "FORWARD":
          tactic["FORWARD"] = tactic["FORWARD"]! + 1;
          break;
      }
    } else {
      if (players[i].isPrimary ?? false) {
        switch (players[i].position) {
          case "MIDFIELDER":
            tactic["MIDFIELDER"] = tactic["MIDFIELDER"]! + 1;
            break;
          case "GOALKEEPER":
            tactic["GOALKEEPER"] = tactic["GOALKEEPER"]! + 1;
            break;
          case "DEFENDER":
            tactic["DEFENDER"] = tactic["DEFENDER"]! + 1;
            break;
          case "FORWARD":
            tactic["FORWARD"] = tactic["FORWARD"]! + 1;
            break;
        }
      }
    }
  }

  int goalkeeper = 0;
  int midfielder = 0;
  int defender = 0;
  int forward = 0;

  for (var player in players) {
    if (isTransferPage) {
      switch (player.position) {
        case "MIDFIELDER":
          primaryTeam[tactic["DEFENDER"]! +
              tactic["GOALKEEPER"]! +
              midfielder] = player;
          midfielder++;
          break;
        case "GOALKEEPER":
          primaryTeam[goalkeeper] = player;
          goalkeeper++;
          break;
        case "DEFENDER":
          primaryTeam[tactic["GOALKEEPER"]! + defender] = player;
          defender++;
          break;
        case "FORWARD":
          primaryTeam[tactic["MIDFIELDER"]! +
              tactic["DEFENDER"]! +
              tactic["GOALKEEPER"]! +
              forward] = player;
          forward++;
          break;
      }
    } else {
      if (player.isPrimary ?? false) {
        switch (player.position) {
          case "MIDFIELDER":
            primaryTeam[tactic["DEFENDER"]! +
                tactic["GOALKEEPER"]! +
                midfielder] = player;
            midfielder++;
            break;
          case "GOALKEEPER":
            primaryTeam[0] = player;
            break;
          case "DEFENDER":
            primaryTeam[tactic["GOALKEEPER"]! + defender] = player;
            defender++;
            break;
          case "FORWARD":
            primaryTeam[tactic["MIDFIELDER"]! +
                tactic["DEFENDER"]! +
                tactic["GOALKEEPER"]! +
                forward] = player;
            forward++;
            break;
        }
      }
    }
  }
  // Oxirgi 2 ta elementni boshidagi 2 ta element bilan almashtirish
  // if (primaryTeam.length >= 2) {
  //   Player firstPlayer = primaryTeam[0];
  //   Player secondPlayer = primaryTeam[1];
  //   Player lastPlayer = primaryTeam[primaryTeam.length - 1];
  //   Player secondLastPlayer = primaryTeam[primaryTeam.length - 2];
  //
  //   // Almashtirish
  //   primaryTeam[0] = secondLastPlayer;
  //   primaryTeam[1] = lastPlayer;
  //   primaryTeam[primaryTeam.length - 2] = firstPlayer;
  //   primaryTeam[primaryTeam.length - 1] = secondPlayer;
  // }
  for (var player in primaryTeam) {
    log("${player.isPrimary} ${player.id} ${player.position} ${player.name} ");
  }

  return [
    [
      tactic["GOALKEEPER"],
      tactic["DEFENDER"],
      tactic["MIDFIELDER"],
      tactic["FORWARD"]
    ],
    primaryTeam
  ];
}

class ChangePlayerFootballField extends StatelessWidget {
  ChangePlayerFootballField({super.key});

  final controller = Get.find<MyTeamController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTeamController>(
      id: 'withoutFiledPlayers',
      builder: (_) {
        log("stream Ushlab oldi ");
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 18 / 24,
              child: Stack(
                children: [
                  Image(
                    image: AssetImage("assets/images/team/football_field.png"),
                    fit: BoxFit.cover,
                    height: 481.h,
                    width: 371.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: buildList(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 38.h,
                        padding: EdgeInsets.only(left: 25),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TacticsMenuButton2(controller: controller),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PlayersCardWidget2(
              players: controller.withoutFiledPlayers,
              function: (player) {
                controller.assignPlayer(player, context: context);
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> buildList(BuildContext context) {
    // Get the current tactic based on controller index
    List<int> currentTactic = tactics[controller.tacticsIndex];
    print(currentTactic);

    // Fetch primary players based on tactic
    var players = getTeamPLayers(controller.team.players!, false);
    controller.primaryTeam = players[1];

    // Saqlangan eski qiymat
    List<Player> previousUsedPlayers = List<Player>.from(controller.usedPlayers);

    List<Widget> list = [];
    controller.usedPlayers.clear();

    // Add the goalkeeper row
    int goalKeeper = currentTactic[0];
    List<Player> goalKeeperList = [
      ...controller.primaryTeam
          .where((p) => p.position == "goalKeeper".toUpperCase()),
      ...controller.selectivePlayers
          .where((p) => p.position == "goalKeeper".toUpperCase()),
    ];
    list.add(buildRow(goalKeeperList, goalKeeper, context));
    if (goalKeeperList.isNotEmpty) {
      controller.usedPlayers.add(goalKeeperList.first);
    }

    // Add the defender row
    int defenders = currentTactic[1];
    List<Player> defendersList = [
      ...controller.primaryTeam
          .where((p) => p.position == "defender".toUpperCase()),
      ...controller.selectivePlayers
          .where((p) => p.position == "defender".toUpperCase()),
    ];
    list.add(buildRow(defendersList, defenders, context));
    for (int i = 0; i < defendersList.length; i++) {
      if (defenders - 1 >= i) controller.usedPlayers.add(defendersList[i]);
    }

    // Add the midfielder row
    int midfielders = currentTactic[2];
    List<Player> midfieldersList = [
      ...controller.primaryTeam
          .where((p) => p.position == "MIDFIELDER".toUpperCase()),
      ...controller.selectivePlayers
          .where((p) => p.position == "MIDFIELDER".toUpperCase()),
    ];
    list.add(buildRow(midfieldersList, midfielders, context));
    for (int i = 0; i < midfieldersList.length; i++) {
      if (midfielders - 1 >= i) controller.usedPlayers.add(midfieldersList[i]);
    }

    // Add the forward row
    int forwards = currentTactic[3];
    List<Player> forwardsList = [
      ...controller.primaryTeam
          .where((p) => p.position == "forward".toUpperCase()),
      ...controller.selectivePlayers
          .where((p) => p.position == "forward".toUpperCase()),
    ];
    list.add(buildRow(forwardsList, forwards, context));
    for (int i = 0; i < forwardsList.length; i++) {
      if (forwards - 1 >= i) controller.usedPlayers.add(forwardsList[i]);
    }

    // Avvalgi va yangi qiymatni solishtirish
    if (!_isListEqual(previousUsedPlayers, controller.usedPlayers)) {
      log("usedPlayers o'zgardi: ${controller.usedPlayers}");
      controller.changePlayersStatus();
      controller.changeSelectivePlayers();
    } else {
      log("usedPlayers o'zgarmadi.");
    }

    return list;
  }
  bool _isListEqual(List<Player> list1, List<Player> list2) {
    if (list1.length != list2.length) return false;

    for (int i = 0; i < list1.length; i++) {
      if (list1[i].id != list2[i].id) {
        return false;
      }
    }
    return true;
  }


  Widget buildRow(List<Player> players, int length, BuildContext context) {
    final controller = Get.find<MyTeamController>();

    return GetBuilder<MyTeamController>(
      id: 'withoutFiledPlayers',
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            length < players.length ? length : players.length,
            (i) {
              Player player = players[i];
              return PointsPlayerWidget1(
                player: player,
                onPressed: () {
                  controller.selectPlayer1(player, context: context);
                },
                onInitPlayer: () =>
                    controller.changeReserve(player, controller.team.id),
              );
            },
          ),
        );
      },
    );
  }
}

//

class TransferFootballField extends StatelessWidget {
  const TransferFootballField({super.key, required this.controller});

  final TransferPageController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransferPageController>(builder: (_) {
      return AspectRatio(
        aspectRatio: 18 / 24,
        child: Stack(
          children: [
            Center(
              child: Image(
                image: AssetImage("assets/images/team/football_field.png"),
                width: 380.w,
                height: 423.h,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buildList(),
              ),
            )
          ],
        ),
      );
    });
  }

  buildList() {
    var players = getTeamPLayers(controller.primaryTeam, true);
    controller.primaryTeam = players[1];

    List<Widget> list = [];

    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        2,
        (i) {
          return PlayerTransferWidget(
            player: controller.primaryTeam[0 + i],
            isExpanded: controller.isExpandedList[0 + i],
            key: UniqueKey(),
          );
        },
      ),
    ));

    list.add(buildRow(5, 2));

    list.add(buildRow(5, 7));

    list.add(buildRow(3, 12));

    return list;
  }

  buildRow(int playerNumber, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        playerNumber,
        (i) => PlayerTransferWidget(
          player: controller.primaryTeam[index + i],
          isExpanded: controller.isExpandedList[index + i],
          key: UniqueKey(),
        ),
      ),
    );
  }
}
