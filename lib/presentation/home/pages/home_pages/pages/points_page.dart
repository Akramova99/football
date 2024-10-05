import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/points_page_controller.dart';
import 'package:football/presentation/widgets/mateches_widget.dart';
import 'package:football/presentation/widgets/points_player_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/img_roots.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  final controller = Get.find<PointsPageController>();

  @override
  void initState() {
    super.initState();
    controller.getTeam();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PointsPageController>(
      builder: (_) {
        return Scaffold(
            body: Stack(
          children: [
            Image.asset(
              ImgRoots.bg2,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 20,
                              )),
                          Padding(
                            padding: EdgeInsets.only(right: 140.w),
                            child: Text(
                              "Ochkolar".tr,
                              style: CustomStyles.appBarStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    !controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Container(
                                height: 109.h,
                                decoration: const BoxDecoration(
                                  color: AppColors.statistic,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                padding: const EdgeInsets.all(
                                  12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  const Color(0xff414158),
                                              child: CachedNetworkImage(
                                                height: 45.h,
                                                width: 41.w,
                                                imageUrl: controller.team.logo,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  'assets/images/team/placeholder.png',
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  'assets/images/team/placeholder.png',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Text(controller.teamName,
                                                style: CustomStyles.appBarStyle
                                                    .copyWith(
                                                        color: Colors.white)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                Image.asset(
                                                  "assets/images/home/polygon.png",
                                                  width: 48,
                                                  height: 50,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 14.0, top: 12),
                                                  child: Text(
                                                    controller.points.maxScore
                                                        .toString(),
                                                    style: CustomStyles
                                                        .appBarStyle
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        Text("${"O'rtacha".tr}: ",
                                            style: CustomStyles.dataTitle!
                                                .copyWith(
                                                    color:
                                                        AppColors.textColor)),
                                        Text(
                                          controller.points.avgScore
                                                  .toString() ??
                                              "",
                                          style: CustomStyles.dataTitle,
                                        ),
                                        Spacer(),
                                        Text("${"Eng Baland ochko".tr} :",
                                            style: CustomStyles.dataTitle!
                                                .copyWith(
                                                    color:
                                                        AppColors.textColor)),
                                        Text(
                                          controller.points.maxScore
                                                  .toString() ??
                                              "",
                                          style: CustomStyles.dataTitle,
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              PointsPageFootballField(controller: controller),
                              PointsPlayerCardWidget(
                                  players: controller.reservePlayers),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                margin: EdgeInsets.all(2),
                                height: 400.h,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 5)
                                    ]),
                                child: MatchListView(
                                  matches: controller.matches,
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}
