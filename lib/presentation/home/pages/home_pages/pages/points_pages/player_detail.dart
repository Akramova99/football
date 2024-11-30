import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/models/player_detail_model.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../../models/team_model.dart';
import '../../../../../../utils/constants/img_roots.dart';
import '../../../../../../utils/constants/styles.dart';
import '../../../../../widgets/player_table_widget.dart';
import '../../../../controllers/search_controller.dart';
import '../../../../widgets/line_chart_sample.dart';
import '../../../statistics/controllers/player_detail_controller.dart';

class PlayerDetailPage2 extends StatefulWidget {
  final Player player;
  final String name;
  final int number;

  const PlayerDetailPage2({
    super.key,
    required this.name,
    required this.player,
    required this.number,
  });

  @override
  State<PlayerDetailPage2> createState() => _PlayerDetailPageState();
}

class _PlayerDetailPageState extends State<PlayerDetailPage2> {
  final controller = Get.find<PlayerDetailController>();

  PlayerDetail cn = PlayerDetail();

  late final SearchMyController controller2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller2 = Get.put(SearchMyController());
    controller2.getPlayerData(widget.name);
    controller.getPlayerDetails(widget.player.id??0);
    Logger().e(widget.player.id);
    controller.getPlayerHistoryDetails(widget.player.id??0);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerDetailController>(builder: (_) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(241, 241, 241, 1),
        body: Stack(
          children: [
            Image.asset(
              ImgRoots.bg2,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, right: 30),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20,
                            )),
                        Spacer(),
                        Text(
                          "O'yinchilar profili".tr,
                          style: CustomStyles.pageTitle,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //  Logger().d(playerModel.playerNumber);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      //   height: 109,
                      decoration: BoxDecoration(
                        color: AppColors.statistic,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: const EdgeInsets.all(
                        12,
                      ),
                      child: GetBuilder<SearchMyController>(builder: (_) {
                        int number = controller2.myPlayer.playerNumber ?? 0;
                        return Column(
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
                                        imageUrl:
                                            controller2.myPlayer.jersey ?? "",
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          'assets/images/team/placeholder.png',
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/team/placeholder.png',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      controller2.myPlayer.name ?? "",
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
                                      padding: const EdgeInsets.only(
                                          left: 14.0, top: 12),
                                      child: Text(
                                        widget.number.toString(),
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "${controller2.myPlayer.price.toString()}\$",
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
                                        controller2.myPlayer.position ?? "",
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
                                      imageUrl:
                                          controller2.myPlayer.clubLogo ?? "",
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/images/team/placeholder.png',
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/team/placeholder.png',
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  Container(
                   width: 380,
                   height: 400,
                   margin: EdgeInsets.symmetric(horizontal: 5),
                   decoration: BoxDecoration(
                       color: AppColors.chartC,
                       borderRadius: BorderRadius.circular(10)),
                   child: LineChartSample2(playerId: controller2.myPlayer.id.toString(),),
                  ),
                  controller.pageIndex == 0
                      ? Padding(
                   padding: const EdgeInsets.symmetric(
                       horizontal: 5.0, vertical: 10),
                   child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: PlayerDataTable(
                     model: controller.current,
                    ),
                   ),
                  )
                      : PlayerDataTable(
                   model: controller.history,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}


