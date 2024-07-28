import 'package:flutter/cupertino.dart';
import 'package:football/models/player_selection_model.dart';

class PlayerSelectionWidget extends StatelessWidget {
  final PlayerSelectionModel player;

  const PlayerSelectionWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          player.jersey != null
              ? Image.network(player.jersey)
              : Image.asset("assets/images/home/player_img.png"),
          SizedBox(
            width: 70,
            child: Text(
              player.name!,
              style: TextStyle(color: CupertinoColors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
