import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/models/team_model.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/points_page_controller.dart';
import 'package:football/utils/constants/constants.dart';

import '../../utils/constants/app_colors.dart';
import '../home/pages/home_pages/pages/players_places.dart';
import 'change_player_football_field.dart';

class PointsPlayerWidget extends StatelessWidget {
  final Player player;

  const PointsPlayerWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: player.isPrimary! ? EdgeInsets.all(5) : EdgeInsets.all(10),
      margin: player.isPrimary!
          ? EdgeInsets.symmetric(horizontal: 0)
          : EdgeInsets.symmetric(horizontal: 2),
      height: player.isPrimary! ? 75.h : 107.h,
      width: player.isPrimary! ? 65.w : 120.w,
      decoration: BoxDecoration(
        color: player.isPrimary!
            ? AppColors.purple.withOpacity(0.5)
            : Colors.grey.withOpacity(0.7),
        border: Border.all(
          color: !player.isPrimary! ? Colors.white : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: player.name != null
          ? Stack(
              alignment: Alignment.center,
              children: [
                if (player.isCapitan ?? false)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 50.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(125, 115, 115, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          player.isCapitan! ? "C" : "",
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.white),
                        ),
                      ),
                    ],
                  ),
                Stack(
                  children: [
                    Container(
                      // color: Colors.red,
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          player.jersey != null
                              ? Flexible(
                                  child: CachedNetworkImage(
                                    imageUrl: player.jersey!,
                                    width: player.isPrimary! ? 60.w : 80.w,
                                    height: player.isPrimary! ? 54.h : 100.h,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Image.asset(
                                      "assets/images/home/player_img.png",
                                      width: 40,
                                    ),
                                  ),
                                )
                              : Image.asset(
                                  "assets/images/home/player_img.png",
                                  width: 40.w,
                                  height: 60.h,
                                  fit: BoxFit.cover,
                                ),
                        ],
                      ),
                    ),
                    !player.isPrimary!
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 45.h,
                              ),
                              Text(
                                "${player.playerNumber ?? ""}",
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white),
                              ),
                              SizedBox(
                                  width: 22.w,
                                  child: Divider(
                                    color: Colors.white,
                                  )),
                              Text(
                                player.name ?? "",
                                style: const TextStyle(
                                    color: CupertinoColors.white, fontSize: 9),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
                player.isPrimary!
                    ? Container(
                        width: 60.w,
                        //   alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  height: 15.h,
                                  width: 12.w,
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
                                    height: 15.h,
                                    alignment: Alignment.center,
                                    color: player.name != null
                                        ? CupertinoColors.white
                                        : Colors.transparent,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        player.name ?? "",
                                        style: const TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 5),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 2,
                              color: Colors.red,
                            ),
                            Container(
                              height: 10.h,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  "MCI(A)",
                                  style:
                                      TextStyle(color: Colors.red, fontSize: 5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            )
          : Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(20),
              height: 65.h,
              width: 60.w,
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
      aspectRatio: 18 / 24,
      child: Stack(
        children: [
          Image(
            image: AssetImage("assets/images/team/football_field.png"),
            width: 371.w,
            height: 481.h,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buildList(),
          )
        ],
      ),
    );
  }

  List<Widget> buildList() {
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

  Widget buildRow(int playerNumber, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        playerNumber,
        (i) =>PointsPlayerWidget1(player: controller.primaryTeam[index + i],)
           // PointsPlayerWidget(player: controller.primaryTeam[index + i]),
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
        height: 265,
        child: Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            // GridView o'z elementlariga moslashishi uchun
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Bir qatorga nechta element joylashtirish
              childAspectRatio: 1, // Elementning kengligi va bo'yi nisbati
              crossAxisSpacing: 1, // Gorizontal bo'shliq
              mainAxisSpacing: 10, // Vertikal bo'shliq
            ),
            itemCount: players.length,
            itemBuilder: (ctx, index) {
              return PointsPlayerWidget(
                player: players[index],
              );
            },
          ),
        )

        //
        // ListView.builder(
        //   physics: NeverScrollableScrollPhysics(),
        // //  itemExtent: 80,
        //   scrollDirection: Axis.horizontal,
        //   itemCount: players.length,
        //   itemBuilder: (ctx, index) {
        //     return PointsPlayerWidget(
        //       player: players[index],
        //     );
        //   },
        // ),
        );
  }
}
