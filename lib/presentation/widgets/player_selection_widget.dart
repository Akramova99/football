import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/models/player_selection_model.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/my_team_controller.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:get/get.dart';

import '../../models/team_model.dart';

class PlayerWidget extends StatelessWidget {
  final PlayerSelectionModel player;

  const PlayerWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      height: 75,
      width: 60,
      decoration: BoxDecoration(
        color: AppColors.purple.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              player.jersey != null
                  ? CachedNetworkImage(
                      imageUrl: player.jersey!,
                      width: 60,
                      height: 54,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        "assets/images/home/player_img.png",
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/home/player_img.png",
                        width: 54,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      "assets/images/home/player_img.png",
                      width: 60,
                      height: 54,
                      fit: BoxFit.cover,
                    ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 10.h,
                      alignment: Alignment.center,
                      color: player.name != null
                          ? const Color.fromRGBO(55, 0, 60, 1)
                          : Colors.transparent,
                      child: Text(
                        "${player.playerNumber ?? ""}",
                        style:
                            const TextStyle(fontSize: 7, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height:  10.h,
                      alignment: Alignment.center,
                      color: player.name != null
                          ? CupertinoColors.white
                          : Colors.transparent,
                      child: SizedBox(
                        // Ensure that FittedBox has constraints
                        height: 15,
                        // Set height based on your layout needs
                        width: double.infinity,
                        // Allow it to fill the available width
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
                  ),
                ],
              ),
              // Red line below player info
              Container(
                height: 2,
                color: Colors.red,
              ),
              // New container for extra info like team name
              Container(
                height: 10,
                color: Colors.white,
                child: const Center(
                  child: Text(
                    "MCI(A)", // Example text for team
                    style: TextStyle(color: Colors.red, fontSize: 5),
                  ),
                ),
              ),
            ],
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
    final controller = Get.find<MyTeamController>();

    return GetBuilder<MyTeamController>(
      builder: (_) {
        controller.checkTactics(1);
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          height: 75.h,
          width: controller.isOne ? 55.w : 60.w,
          decoration: BoxDecoration(
            color: AppColors.purple.withOpacity(0.5),
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
                            child: Center(
                              child: Text(
                                player.isCapitan! ? "C" : "",
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        player.jersey != null
                            ? Flexible(
                                child: CachedNetworkImage(
                                  imageUrl: player.jersey!,
                                  width: 60.w,
                                  height: 54.h,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.asset(
                                    "assets/images/home/player_img.png",
                                    width: 40.w,
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
                    Container(
                      width: 60.w,
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
                                ),
                              ),
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
                        ],
                      ),
                    ),
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
                    onTap: () {
                      Get.find<MyTeamController>().selectPlayer(player);
                    },
                  ),
                ),
        );
      },
    );
  }
}

class PlayerTransferWidget extends StatelessWidget {
  final Player player;
  final bool isExpanded;

  const PlayerTransferWidget(
      {super.key, required this.player, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(2),
      height: 87.h,
      width: 58.w,
      decoration: BoxDecoration(
        color: AppColors.purple.withOpacity(0.5),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    player.jersey != null
                        ? Flexible(
                            child: CachedNetworkImage(
                              imageUrl: player.jersey!,
                              width: 60.w,
                              height: 54.h,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                "assets/images/home/player_img.png",
                                width: 40,
                              ),
                            ),
                          )
                        : Image.asset(
                            "assets/images/home/player_img.png",
                            width: 40,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                  ],
                ),
                Container(
                  width: 60.w,
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
                      // Container(
                      //   height: 2,
                      //   color: Colors.red,
                      // ),
                      // Container(
                      //   height: 10.h,
                      //   color: Colors.white,
                      //   child: Center(
                      //     child: Text(
                      //       "MCI(A)",
                      //       style: TextStyle(color: Colors.red, fontSize: 5),
                      //     ),
                      //   ),
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.find<TransferPageController>()
                                  .selectPlayer(player);
                            },
                            child: SizedBox(
                              height: 22.h,
                              width: 22.w,
                              child:
                                  Image.asset("assets/images/transfer/no.png"),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.find<TransferPageController>()
                                  .sellPLayer(player);
                            },
                            child: SizedBox(
                              height: 23.h,
                              width: 23.w,
                              child:
                                  Image.asset("assets/images/transfer/yes.png"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                onTap: () {
                  Get.find<TransferPageController>().selectPlayer(player);
                  Get.find<TransferPageController>()
                      .searchPlayers(player.position);
                },
              ),
            ),
    );
  }
}

class PlayerTransferCardWidget extends StatelessWidget {
  final Player player;

  const PlayerTransferCardWidget(
      {super.key, required this.player, required this.isExpanded});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return player.name == null
        ? Container(
            height: 75.h,
            width: 60.w,
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/images/home/player_img.png",
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(5),
            height: isExpanded ? 110.h : 75.h,
            width: 60.w,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (player.name != null) {
                      //Get.find<TransferPageController>().selectPlayer(player);
                      print("field");
                      print(player.name);
                    }
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      player.name != null
                          ? player.isCapitan ?? false
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      height: 50.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(125, 115, 115, 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        width: 6.w,
                                        height: 9.h,
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
                              : SizedBox()
                          : SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          player.jersey != null
                              ? Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.playerBg
                                            .withOpacity(0.55),
                                      ),
                                      width: 60.w,
                                      height: 54.h,
                                    ),
                                    CachedNetworkImage(
                                      imageUrl: player.jersey!,
                                      // player.jersey!,
                                      width: 60.w,
                                      height: 54.h,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        "assets/images/home/player_img.png",
                                        width: 40.w,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/home/player_img.png",
                                        width: 54.w,
                                      ),
                                    )
                                  ],
                                )
                              : Image.asset(
                                  "assets/images/home/player_img.png",
                                  width: 40.w,
                                ),
                        ],
                      ),
                      Container(
                        height: 12.h,
                        width: 60.w,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
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
                                alignment: Alignment.center,
                                color: player.name != null
                                    ? CupertinoColors.white
                                    : Colors.transparent,
                                child: Text(
                                  player.name!,
                                  style: const TextStyle(
                                      color: CupertinoColors.black,
                                      fontSize: 5),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isExpanded)
                  Column(
                    children: [
                      Text(
                        "\$${player.price ?? ""}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child:
                                  Image.asset("assets/images/transfer/no.png"),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.find<TransferPageController>()
                                  .buyPlayer(player);
                            },
                            child: SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child:
                                  Image.asset("assets/images/transfer/yes.png"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  const SizedBox(),
              ],
            ),
          );
  }
}
