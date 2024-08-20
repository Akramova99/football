import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/points_page_controller.dart';
import 'package:football/presentation/widgets/mateches_widget.dart';
import 'package:football/presentation/widgets/points_player_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

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
                                SizedBox(
                                  width: 5,
                                ),
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
                                Text("O'rtacha: "),
                                Text(controller.points.avgScore.toString() ??
                                    ""),
                                Spacer(),
                                Text("Mening ochkoyim: "),
                                Text(controller.team.totalScore.toString() ??
                                    ""),
                                Spacer(),
                                Text("Eng yaxshi: "),
                                Text(controller.points.maxScore.toString() ??
                                    ""),
                              ],
                            ),
                            PointsPageFootballField(controller: controller),
                            PointsPlayerCardWidget(
                                players: controller.reservePlayers),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.all(2),
                              height: 400,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey, blurRadius: 5)
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
        );
      },
    );
  }
}
