import 'package:flutter/cupertino.dart';
import 'package:football/models/player_selection_model.dart';
import 'package:football/presentation/widgets/player_selection_widget.dart';

class PlayersCardWidget extends StatelessWidget {
  final List<PlayerSelectionModel> players;

  const PlayersCardWidget({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(41, 169, 107, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: players.length,
          itemBuilder: (ctx, index) {
            return PlayerSelectionWidget(player: players[index]);
          }),
    );
  }
}
