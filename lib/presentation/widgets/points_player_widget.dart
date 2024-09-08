import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/models/team_model.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/points_page_controller.dart';
import 'package:football/utils/constants/constants.dart';

import 'change_player_football_field.dart';

class PointsPlayerWidget extends StatelessWidget {
  final Player player;

  const PointsPlayerWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 75,
      width: 60,
      child: player.name != null
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                player.isCapitan!
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 50,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(125, 115, 115, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: 6,
                              height: 9,
                              child: Text(
                                player.isCapitan != null
                                    ? player.isCapitan!
                                        ? "C"
                                        : ""
                                    : "",
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    player.jersey != null
                        ? CachedNetworkImage(
                            imageUrl: player.jersey!,
                            // player.jersey!,
                            width: 60,
                            height: 54,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                              "assets/images/home/player_img.png",
                              width: 40,
                            ),
                          )
                        : Image.asset(
                            "assets/images/home/player_img.png",
                            width: 40,
                          ),
                  ],
                ),
                Container(
                  height: 20,
                  width: 60,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 10,
                            width: 12,
                            alignment: Alignment.center,
                            color: const Color.fromRGBO(55, 0, 60, 1),
                            child: Text(
                              "${player.playerNumber ?? ""}",
                              style: const TextStyle(
                                  fontSize: 7, color: Colors.white),
                            ),
                          )),
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 10,
                              alignment: Alignment.center,
                              color: player.name != null
                                  ? CupertinoColors.white
                                  : Colors.transparent,
                              child: Text(
                                player.name ?? "",
                                style: const TextStyle(
                                    color: CupertinoColors.black, fontSize: 5),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          "${player.score ?? "-"}",
                          style: TextStyle(fontSize: 7),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : Container(
              padding: EdgeInsets.all(5),
              height: 65,
              width: 60,
              child: GestureDetector(
                child: Image.asset(
                  "assets/images/home/player_img.png",
                  fit: BoxFit.cover,
                ),
                onTap: () {},
              ),
            ),
    );
  }
}

class PointsPageFootballField extends StatelessWidget {
  const PointsPageFootballField({super.key, required this.controller});

  final PointsPageController controller;

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buildList(),
          )
        ],
      ),
    );
  }

  buildList() {
    var players = getTeamPLayers(controller.team.players!, false);
    controller.primaryTeam = players[1];
    var index = tacticsString.indexOf(controller.tactica);

    List<Widget> list = [];
    var goalKeeper = tactics[index][0];
    list.add(buildRow(goalKeeper, 0));

    var defender = tactics[index][1];
    list.add(buildRow(defender, goalKeeper));

    var midfielder = tactics[index][2];
    list.add(buildRow(midfielder, defender + goalKeeper));

    var forward = tactics[index][3];
    list.add(buildRow(forward, defender + midfielder + goalKeeper));

    return list;
  }

  buildRow(int playerNumber, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        playerNumber,
        (i) => PointsPlayerWidget(player: controller.primaryTeam[index + i]),
      ),
    );
  }
}

class PointsPlayerCardWidget extends StatelessWidget {
  final List<Player> players;

  const PointsPlayerCardWidget({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(94, 129, 58, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
          itemExtent: 80,
          scrollDirection: Axis.horizontal,
          itemCount: players.length,
          itemBuilder: (ctx, index) {
            return PointsPlayerWidget(
              player: players[index],
            );
          }),
    );
  }
}
