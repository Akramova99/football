import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/models/player_selection_model.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:get/get.dart';

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
            height: 12,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  width: 12,
                  alignment: Alignment.center,
                  color: player.name != null
                      ? const Color.fromRGBO(55, 0, 60, 1)
                      : Colors.transparent,
                  child: Text(
                    "${player.playerNumber ?? ""}",
                    style: const TextStyle(fontSize: 5, color: Colors.white),
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
      height: 65,
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
            height: 12,
            width: 60,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  width: 12,
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(55, 0, 60, 1),
                  child: Text(
                    "${player.playerNumber ?? ""}",
                    style: const TextStyle(fontSize: 7, color: Colors.white),
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
          ),
        ],
      ),
    );
  }
}

// class PlayerTransferWidget extends StatelessWidget {
//   final Player player;
//
//   const PlayerTransferWidget({super.key, required this.player});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(5),
//       height: 85,
//       width: 60,
//       child: Column(
//         children: [
//           Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               player.isCapitan != null
//                   ? player.isCapitan!
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(5),
//                               height: 50,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                   color: Color.fromRGBO(125, 115, 115, 1),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Container(
//                                 width: 6,
//                                 height: 9,
//                                 child: Text(
//                                   player.isCapitan != null
//                                       ? player.isCapitan!
//                                           ? "C"
//                                           : ""
//                                       : "",
//                                   style: const TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.bold,
//                                       color: CupertinoColors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       : SizedBox()
//                   : SizedBox(),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   player.jersey != null
//                       ? Image.network(
//                           player.jersey!,
//                           width: 60,
//                           height: 54,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.asset(
//                           "assets/images/home/player_img.png",
//                           width: 40,
//                         ),
//                 ],
//               ),
//               Container(
//                 height: 12,
//                 width: 60,
//                 alignment: Alignment.center,
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: Container(
//                       width: 12,
//                       alignment: Alignment.center,
//                       color: const Color.fromRGBO(55, 0, 60, 1),
//                       child: Text(
//                         "${player.playerNumber ?? ""}",
//                         style:
//                             const TextStyle(fontSize: 7, color: Colors.white),
//                       ),
//                     )),
//                     Expanded(
//                       flex: 4,
//                       child: Container(
//                         alignment: Alignment.center,
//                         color: player.name != null
//                             ? CupertinoColors.white
//                             : Colors.transparent,
//                         child: Text(
//                           player.name ?? "",
//                           style: const TextStyle(
//                               color: CupertinoColors.black, fontSize: 5),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [],
//               )
//             ],
//           ),
//           Container(
//             child: player != null
//                 ? Row(
//                     children: [Text("${player.price}"),],
//                   )
//                 : SizedBox(),
//           )
//         ],
//       ),
//     );
//   }
// }

class PlayerTransferWidget extends StatelessWidget {
  final Player player;

  const PlayerTransferWidget(
      {super.key, required this.player, required this.isExpanded});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return player.name == null
        ? Container(
            height: 75,
            width: 60,
            child: GestureDetector(
              onTap: () {
                Get.find<TransferPageController>().selectPlayer(player);
              },
              child: Image.asset(
                "assets/images/home/player_img.png",
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(5),
            height: isExpanded ? 110 : 75,
            width: 60,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (player.name != null) {
                      Get.find<TransferPageController>().selectPlayer(player);
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
                                      height: 50,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(125, 115, 115, 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                        height: 12,
                        width: 60,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
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
                              height: 20,
                              width: 20,
                              child:
                                  Image.asset("assets/images/transfer/no.png"),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.find<TransferPageController>()
                                  .sellPLayer(player);
                            },
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  Image.asset("assets/images/transfer/yes.png"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  SizedBox(),
              ],
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
      height: 75,
      width: 60,
      child: GestureDetector(
        onTap: () {

        },
        child: Image.asset(
          "assets/images/home/player_img.png",
        ),
      ),
    )
        : Container(
      padding: EdgeInsets.all(5),
      height: isExpanded ? 110 : 75,
      width: 60,
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
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                          color:
                          Color.fromRGBO(125, 115, 115, 1),
                          borderRadius:
                          BorderRadius.circular(10)),
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
                  height: 12,
                  width: 60,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
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
                        height: 20,
                        width: 20,
                        child:
                        Image.asset("assets/images/transfer/no.png"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.find<TransferPageController>()
                            .assignPlayer(player);
                      },
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child:
                        Image.asset("assets/images/transfer/yes.png"),
                      ),
                    ),
                  ],
                ),
              ],
            )
          else
            SizedBox(),
        ],
      ),
    );
  }
}