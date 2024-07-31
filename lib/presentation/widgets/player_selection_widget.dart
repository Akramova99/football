import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/models/player_selection_model.dart';

import '../../models/team_model.dart';

class PlayerWidget extends StatelessWidget {
  final PlayerSelectionModel player;

  const PlayerWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 70,
      width: 60,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              player.jersey != null
                  ? Image.network(
                      player.jersey,
                      width: 60,
                      height: 54,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/images/home/player_img.png",
                      width: 40,
                    ),
            ],
          ),
          Container(
            height: 15,
            alignment: Alignment.center,
            color: player.name != null
                ? CupertinoColors.white
                : Colors.transparent,
            child: Text(
              player.name ?? "",
              style:
                  const TextStyle(color: CupertinoColors.black, fontSize: 10),
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

class PlayerSelectionWidget extends StatelessWidget {
  final Player player;

  const PlayerSelectionWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 70,
      width: 60,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          player.isCapitan != null
              ? player.isCapitan!
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 20,
                          color: CupertinoColors.systemGrey,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            player.isCapitan != null
                                ? player.isCapitan!
                                    ? "C"
                                    : ""
                                : "",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.white),
                          ),
                        ),
                      ],
                    )
                  : SizedBox()
              : SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              player.jersey != null
                  ? Image.network(
                      player.jersey!,
                      width: 60,
                      height: 54,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/images/home/player_img.png",
                      width: 40,
                    ),
            ],
          ),
          Container(
            height: 15,
            alignment: Alignment.center,
            color: player.name != null
                ? CupertinoColors.white
                : Colors.transparent,
            child: Text(
              player.name ?? "",
              style:
                  const TextStyle(color: CupertinoColors.black, fontSize: 10),
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
