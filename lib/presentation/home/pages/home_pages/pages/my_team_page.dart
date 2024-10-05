import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/my_team_controller.dart';
import 'package:football/presentation/widgets/players_card_widget.dart';
import 'package:football/presentation/widgets/team_name_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/constants/img_roots.dart';
import '../../../../widgets/change_player_football_field.dart';

import '../../settings_pages/controllers/profile_page_controller.dart';

class MyTeamPage extends StatefulWidget {
  const MyTeamPage({super.key});

  @override
  State<MyTeamPage> createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {
  final controller = Get.find<MyTeamController>();
  final profileController = Get.find<ProfilePageController>(); // Get the profile controller

  @override
  void initState() {
    super.initState();
    controller.getTeam();
    profileController.getData(); // Ensure profile data is loaded
  }

  @override
  void dispose() {
    super.dispose();
    controller.changeTactic();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTeamController>(
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
                              padding: EdgeInsets.only(right: 80.w),
                              child: Text(
                                "Mening Jamoam".tr,
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
                          // Use name and icon from profileController
                          GetBuilder<ProfilePageController>(
                            builder: (_) {
                              return TeamNameWidget2(
                                icon: profileController.user.image ?? "",
                                name: profileController.name ?? "",
                                controller: controller,
                              );
                            },
                          )
                          ,
                          SizedBox(
                            height: 5,
                          ),
                          ChangePlayerFootballField(
                            controller: controller,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          PlayersCardWidget2(
                            players: controller.selectivePlayers,
                            function: controller.assignPlayer,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
