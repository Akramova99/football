import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:football/presentation/intro/controllers/capitan_selection_controller.dart';
import 'package:football/presentation/intro/controllers/create_team_controller.dart';
import 'package:football/presentation/widgets/player_selection_widget.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:football/utils/converter.dart';
import 'package:get/get.dart';

import '../../models/team_model.dart';
import 'change_player_football_field.dart';

class CreateTeamWidget extends StatelessWidget {
  const CreateTeamWidget({super.key, required this.controller});

  final CreateTeamController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1501 / 2400,
      child: Stack(
        children: [
          const Image(
            image: AssetImage("assets/images/team/football_field.png"),
            fit: BoxFit.fitWidth,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildList(),
          )
        ],
      ),
    );
  }

  buildList() {
    var players = getTeamPLayers(
        convertPlayerSelectionModelListToPlayerList(controller.playersInField),
        true);
    controller.playersInField =
        convertPlayerListToPlayerSelectionModelList(players[1]);
    List<Widget> list = [];
    var goalKeeper = 2;

    list.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          goalKeeper,
          (i) => GestureDetector(
            onTap: () {
              controller.selectPlayer(reversePosition[0]!, 0 + i);
            },
            child: PlayerWidget(player: controller.playersInField[0 + i]),
          ),
        )));

    var defender = 5;
    list.add(buildRow(defender, 1, goalKeeper));

    var midfielder = 5;
    list.add(buildRow(midfielder, 2, defender + goalKeeper));

    var forward = 3;
    list.add(buildRow(forward, 3, defender + midfielder + goalKeeper));
    return list;
  }

  buildRow(int playerNumber, int position, int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          playerNumber,
          (i) => GestureDetector(
            onTap: () {
              controller.selectPlayer(reversePosition[position]!, index + i);
            },
            child: PlayerWidget(player: controller.playersInField[index + i]),
          ),
        ));
  }
}

// class FootballFieldWidget extends StatefulWidget {
//   final List<Player> players;
//   final Function function;
//
//   const FootballFieldWidget(
//       {super.key, required this.players, required this.function});
//
//   @override
//   State<FootballFieldWidget> createState() => _FootballFieldWidgetState();
// }
//
// class _FootballFieldWidgetState extends State<FootballFieldWidget> {
//   final controller = Get.find<FootballFieldController>();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     Get.delete<FootballFieldController>();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FootballFieldController>(builder: (_) {
//       return AspectRatio(
//         aspectRatio: 1501 / 2400,
//         child: Stack(
//           children: [
//             const Image(
//               image: AssetImage("assets/images/team/football_field.png"),
//               fit: BoxFit.fitWidth,
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: buildList(),
//               ),
//             )
//           ],
//         ),
//       );
//     });
//   }
//
//   buildList() {
//     var players = getTeamPLayers(widget.players, true);
//
//     List<Widget> list = [];
//     var goalKeeper = 2;
//     list.add(buildRow(goalKeeper, 0));
//
//     var defender = 5;
//     list.add(buildRow(defender, goalKeeper));
//
//     var midfielder = 5;
//     list.add(buildRow(midfielder, defender + goalKeeper));
//
//     var forward = 3;
//     list.add(buildRow(forward, defender + midfielder + goalKeeper));
//
//     return list;
//   }
//
//   buildRow(int playerNumber, int index) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: List.generate(
//         playerNumber,
//         (i) => GestureDetector(
//           onTap: () {
//             widget.function(widget.players[index + i]);
//             controller.updateUi();
//           },
//           child: PlayerSelectionWidget(player: widget.players[index + i]),
//         ),
//       ),
//     );
//   }
// }
//
// class FootballFieldController extends GetxController {
//   late List<Player> players;
//
//   getTeam(players) {
//     this.players = players;
//     update();
//   }
//
//   List<Player> primaryTeam = List.generate(
//     16,
//     (index) => Player(),
//   );
//   Map<String, int> tactic = {
//     "MIDFIELDER": 0,
//     "GOALKEEPER": 0,
//     "DEFENDER": 0,
//     "FORWARD": 0,
//   };
//
//   getTactic() async {
//     for (var i = 0; i < players.length; i++) {
//       if (players[i].isPrimary ?? false) {
//         switch (players[i].position) {
//           case "MIDFIELDER":
//             tactic["MIDFIELDER"] = tactic["MIDFIELDER"]! + 1;
//             break;
//           case "GOALKEEPER":
//             tactic["GOALKEEPER"] = tactic["GOALKEEPER"]! + 1;
//             break;
//           case "DEFENDER":
//             tactic["DEFENDER"] = tactic["DEFENDER"]! + 1;
//             break;
//           case "FORWARD":
//             tactic["FORWARD"] = tactic["FORWARD"]! + 1;
//             break;
//         }
//       }
//     }
//   }
//
//   int goalkeeper = 0;
//   int midfielder = 0;
//   int defender = 0;
//   int forward = 0;
//
//   getPrimaryTeam() async {
//     for (var player in players) {
//       if (player.isPrimary ?? false) {
//         switch (player.position) {
//           case "MIDFIELDER":
//             primaryTeam[tactic["DEFENDER"]! +
//                 tactic["GOALKEEPER"]! +
//                 midfielder] = player;
//             midfielder++;
//             break;
//           case "GOALKEEPER":
//             primaryTeam[0] = player;
//             break;
//           case "DEFENDER":
//             primaryTeam[tactic["GOALKEEPER"]! + defender] = player;
//             defender++;
//             break;
//           case "FORWARD":
//             primaryTeam[tactic["MIDFIELDER"]! +
//                 tactic["DEFENDER"]! +
//                 tactic["GOALKEEPER"]! +
//                 forward] = player;
//             forward++;
//             break;
//         }
//       }
//     }
//   }
//
//   updateUi() {
//     update();
//   }
// }

class CapitanSelectionWidget extends StatelessWidget {
  const CapitanSelectionWidget({super.key, required this.controller});

  final CapitanSelectionController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1501 / 2400,
      child: Stack(
        children: [
          const Image(
            image: AssetImage("assets/images/team/football_field.png"),
            fit: BoxFit.fitWidth,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildList(),
          )
        ],
      ),
    );
  }

  buildList() {
    var players = getTeamPLayers(controller.players, true);
    controller.players = players[1];
    List<Widget> list = [];
    var goalKeeper = 2;

    list.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          goalKeeper,
          (i) => GestureDetector(
            onTap: () {
              controller.selectPlayer(controller.players[i]);
            },
            child: PlayerSelectionWidget(player: controller.players[i]),
          ),
        )));

    var defender = 5;
    list.add(buildRow(defender, 1, goalKeeper));

    var midfielder = 5;
    list.add(buildRow(midfielder, 2, defender + goalKeeper));

    var forward = 3;
    list.add(buildRow(forward, 3, defender + midfielder + goalKeeper));
    return list;
  }

  buildRow(int playerNumber, int position, int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          playerNumber,
          (i) => GestureDetector(
            onTap: () {
              controller.selectPlayer(controller.players[i + index]);
            },
            child: PlayerSelectionWidget(player: controller.players[i + index]),
          ),
        ));
  }
}
