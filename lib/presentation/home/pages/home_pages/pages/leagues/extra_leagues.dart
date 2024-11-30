import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/extra_leagues_page_controller.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:football/utils/constants/img_roots.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../widgets/custom_button.dart';

class ExtraLeaguesPage extends StatefulWidget {
  const ExtraLeaguesPage({super.key});

  @override
  State<ExtraLeaguesPage> createState() => _ExtraLeaguesPageState();
}

class _ExtraLeaguesPageState extends State<ExtraLeaguesPage> {
  final controller = Get.find<ExtraLeaguesPageController>();

  @override
  void initState() {
    super.initState();
    controller.getLeagues();
    controller.getMyLeagues();
    controller.getMyLeaguesDetails();
    controller.getJoinedTeam();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExtraLeaguesPageController>(
      builder: (_) {
        var league = controller.myExtraLeagues;
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 63,
                width: double.infinity,
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                decoration: BoxDecoration(
                    color: AppColors.baseColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Text(
                  textAlign: TextAlign.center,
                  league.description ?? text.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: Image.asset(
                          ImgRoots.bg4,
                          height: 338,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CachedNetworkImage(
                              imageUrl: league.image ?? "",
                              placeholder: (context, url) {
                                return Image.asset(
                                  "assets/images/home/league1.png",
                                  height: 221,
                                  fit: BoxFit.cover,
                                );
                              },
                              errorWidget: (context, url, error) {
                                print("+++++++++++++++++++++++$error");
                                print("+++++++++++++++++++++++$url");
                                return Image.asset(
                                  "assets/images/home/league1.png",
                                  height: 221,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          Text(
                            "${"Ochiq Osiyo chempionati".tr}(MW${controller.league.startWeek?.weekNumber ?? ""}-MW${controller.league.endWeek?.weekNumber})",
                            style: const TextStyle(
                                color: Color.fromRGBO(0, 185, 0, 1),
                                fontSize: 13),
                          ),
                          Row(
                            children: [
                              Text(
                                "${"Jamoalar".tr}:",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 13),
                              ),
                              Text(
                                " ${controller.joinTeam.joinedTeams}/${controller.joinTeam.totalTeams}",
                                style: const TextStyle(
                                    color: Color.fromRGBO(0, 185, 0, 1),
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(),
                          CustomButton(
                            color: AppColors.baseColor,
                            text: "Ushbu sovrinli ligaga qo'shiling".tr,
                            onPress: () {},
                          )
                        ],
                      ),
                    ),
                  ], //Open Asia Championship (MW1-MW4)
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
