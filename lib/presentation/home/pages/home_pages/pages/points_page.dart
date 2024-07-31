import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/points_page_controller.dart';
import 'package:football/presentation/widgets/team_name_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../widgets/football_field_widget.dart';

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
          appBar: AppBar(
            title: Text(
              "Ochkolar",
              style: CustomStyles.pageTitle,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Jamoam ",
                                  style: CustomStyles.team,
                                ),
                                Text(
                                  controller.teamName,
                                  style: CustomStyles.teamName,
                                ),
                                SizedBox(width: 5,),
                                controller.team.logo != null
                                    ? SizedBox(
                                        width: 30,
                                        height: 30,
                                        child:
                                            Image.network(controller.team.logo))
                                    : const SizedBox()
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "MW points",
                                        style: CustomStyles.team,
                                      ),
                                      Text(
                                        "${controller.team.totalScore} PTS",
                                        style: const TextStyle(
                                            fontSize: 32, color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Other Players",
                                      style: CustomStyles.team,
                                    ),
                                    Text(
                                        "Best:  ${controller.points.maxScore ?? ""} pts"),
                                    Text(
                                        "Average:  ${controller.points.avgScore ?? ""} pts"),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TeamNameWidget(
                              name: controller.teamName,
                              icon: controller.team.logo,
                            ),
                            FootballFieldWidget(
                              players: controller.team.players!,
                              function: () {},
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
