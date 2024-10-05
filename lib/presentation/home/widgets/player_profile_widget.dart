import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:logger/logger.dart';

import '../../../models/statistic_model.dart';
import '../pages/statistics/controllers/player_detail_controller.dart';

class PlayerDetailWidget extends StatelessWidget {
  //i need PlayerDetailModel

  final PlayerDetailController controller;
  final  StatisticModel playerModel;

  const PlayerDetailWidget({
    super.key,
    required this.controller,
    required this.playerModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Logger().d(playerModel.playerNumber);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
     //   height: 109,
        decoration: BoxDecoration(
          color: AppColors.statistic,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        padding: const EdgeInsets.all( 12,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xff414158),
                      child: CachedNetworkImage(
                        height: 45,
                        width: 41,
                        imageUrl: playerModel.playerJersey ?? "",
                        placeholder: (context, url) => Image.asset(
                          'assets/images/team/placeholder.png',
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/team/placeholder.png',
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      playerModel.playerName ?? "",
                      style: CustomStyles.appBarStyle
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),

                Stack(
                  children: [
                    Image.asset(
                      "assets/images/home/polygon.png",
                      width: 48,
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, top: 12),
                      child: Text(
                        playerModel.playerNumber
                                .toString() ??
                            "",
                        style: CustomStyles.appBarStyle
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),

            // Text(
            //   data["label"]!,
            //   style: const TextStyle(
            //       fontSize: 8,
            //       color: AppColors.textColor,
            //       fontFamily: "Poppins",
            //       fontWeight: FontWeight.w500),
            // ),
            Row(
 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    const Text(
                      "Narxi:",
                      style: TextStyle(
                          fontSize: 13.14,
                          color: AppColors.textColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${controller.modelCurrent?.player?.price.toString()}\$",
                        style: const TextStyle(
                            fontSize: 13.14,
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),

                Row(
                  children: [
                    const Text(
                      "Pozitsiyasi:",
                      style: TextStyle(
                          fontSize: 13.14,
                          color: AppColors.textColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        controller.modelCurrent?.player?.position!??"",
                        style: const TextStyle(
                            fontSize: 13.14,
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Klubi: ",
                      style: TextStyle(
                          fontSize: 13.14,
                          color: AppColors.textColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8.0),
                    //   child:   Image.asset(
                    //     "assets/images/team/club_img.png",
                    //     width: 23,
                    //     height: 20,
                    //   ),
                    // ),
                    CachedNetworkImage(
                      height: 20,
                      width: 23,
                      imageUrl: playerModel.clubLogo ?? "",
                      placeholder: (context, url) => Image.asset(
                        'assets/images/team/placeholder.png',
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/team/placeholder.png',
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
