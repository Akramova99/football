import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/team_detail_page_controller.dart';
import 'package:football/presentation/widgets/team_name_widget.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/styles.dart';
import '../../../../../widgets/change_player_football_field.dart';
import '../players_places.dart';

class TeamDetailPage extends StatefulWidget {
  final int id;

  const TeamDetailPage({super.key, required this.id});

  @override
  State<TeamDetailPage> createState() => _TeamDetailPageState();
}

class _TeamDetailPageState extends State<TeamDetailPage> {
  final controller = Get.find<TeamDetailPageController>();

  @override
  void initState() {
    super.initState();
    controller.getTeam(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeamDetailPageController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Team detail"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (controller.isLoading)
                  const CircularProgressIndicator()
                else
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: AppColors.field.withOpacity(0.45),
                            border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(
                                  10,
                                ),
                                bottomLeft: Radius.circular(10))),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                controller.team.name ?? "",
                                style: CustomStyles.pageTitle!.copyWith(color: Colors.white),
                              ),
                            ),
                            Spacer(),
                            CachedNetworkImage(
                              height: 32,
                              width: 27,
                              imageUrl: controller.team.logo ?? "",
                              placeholder: (context, url) => Container(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TeamDetailWidget(
                        controller: controller,
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TeamDetailWidget extends StatelessWidget {
  const TeamDetailWidget({
    super.key,
    required this.controller,
  });

  final TeamDetailPageController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1501 / 2400,
      child: Stack(
        children: [
          Center(
            child: Image(
              image: AssetImage("assets/images/team/football_field.png"),
              fit: BoxFit.cover,
              width: 370.w,
              height: 510.h,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildList(),
          )
        ],
      ),
    );
  }

  buildList() {
    var players = getTeamPLayers(controller.players, true);
    controller.players = players[1];
    List<Widget> list = [];

    // Har bir pozitsiyadagi o'yinchilarni PointsPlayerWidget1 asosida chiqaramiz
    var goalKeeper = 2;
    list.add(buildRow(goalKeeper, 0));

    var defender = 5;
    list.add(buildRow(defender, goalKeeper));

    var midfielder = 5;
    list.add(buildRow(midfielder, defender + goalKeeper));

    var forward = 3;
    list.add(buildRow(forward, defender + midfielder + goalKeeper));

    return list;
  }

  buildRow(int playerNumber, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        playerNumber,
            (i) => PointsPlayerWidget1(
          player: controller.players[index + i],
          onPressed: () {},
          myTeam: controller.team,
          onInitPlayer: () {
            // controller.changeReserve(controller.players[index + i], controller.team.id);
          },
        ),
      ),
    );
  }
}
