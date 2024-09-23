import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/styles.dart';

import '../pages/statistics/controllers/player_detail_controller.dart';

class PlayerDetailWidget extends StatelessWidget {
  //i need PlayerDetailModel

  final PlayerDetailController controller;

  const PlayerDetailWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        height: 109,
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
                        imageUrl: controller.modelCurrent?.player?.jersey ?? "",
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
                      controller.modelCurrent?.player?.name ?? "",
                      style: CustomStyles.appBarStyle
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(width: 90,),
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
                        controller.modelCurrent?.player?.playerNumber
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
              Row(
                children: [
                  Text(
                    "Narxi:",
                    style: const TextStyle(
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

                Row(
                  children: [
                    Text(
                      "Pozitsiyasi:",
                      style: const TextStyle(
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
                    Text(
                      "Klubi:",
                      style: const TextStyle(
                          fontSize: 13.14,
                          color: AppColors.textColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child:   Image.asset(
                        "assets/images/team/club_img.png",
                        width: 23,
                        height: 20,
                      ),
                    ),
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
