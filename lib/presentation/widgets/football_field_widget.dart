import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:football/presentation/intro/controllers/capitan_selection_controller.dart';
import 'package:football/presentation/intro/controllers/create_team_controller.dart';
import 'package:football/presentation/widgets/player_selection_widget.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:football/utils/converter.dart';

import '../../../utils/size.dart';
import 'change_player_football_field.dart';

class CreateTeamWidget extends StatelessWidget {
  const CreateTeamWidget({super.key, required this.controller});

  final CreateTeamController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1501 / 1700, //2400
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Center(
              child: Image(
                image:
                    const AssetImage("assets/images/team/football_field.png"),
                fit: BoxFit.cover,
                width: 370.w,
                height: 423.h,
              ),
            ),
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
      ),
    ));

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

class CapitanSelectionWidget extends StatelessWidget {
  const CapitanSelectionWidget({super.key, required this.controller});

  final CapitanSelectionController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1501 / 2100,
      child: Stack(
        children: [
          Center(
            child: Image(
              width: 370.w,
              height: 462.h,
              image: AssetImage("assets/images/team/football_field.png"),
              fit: BoxFit.cover,
            ),
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
