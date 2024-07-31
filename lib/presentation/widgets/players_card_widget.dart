import 'package:flutter/cupertino.dart';
import 'package:football/models/player_selection_model.dart';
import 'package:football/presentation/widgets/player_selection_widget.dart';
import 'package:football/utils/converter.dart';

import '../../models/team_model.dart';

class PlayersCardWidget extends StatelessWidget {
  final List<PlayerSelectionModel> players;
  final Function function;

  const PlayersCardWidget(
      {super.key, required this.players, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 80,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(41, 169, 107, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: players.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: PlayerWidget(player: players[index])),
              onTap: () {
                function(players[index]);
              },
            );
          }),
    );
  }
}

class PlayersCardWidget2 extends StatelessWidget {
  final List<Player> players;
  final Function function;

  const PlayersCardWidget2(
      {super.key, required this.players, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(41, 169, 107, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: players.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              child: PlayerWidget(
                  player: convertToPlayerSelectionModel(players[index])),
              onTap: () {
                function(players[index]);
              },
            );
          }),
    );
  }
}
