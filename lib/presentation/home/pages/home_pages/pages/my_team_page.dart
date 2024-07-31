import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/my_team_controller.dart';
import 'package:football/presentation/widgets/football_field_widget.dart';
import 'package:football/presentation/widgets/players_card_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class MyTeamPage extends StatefulWidget {
  const MyTeamPage({super.key});

  @override
  State<MyTeamPage> createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {
  final controller = Get.find<MyTeamController>();

  @override
  void initState() {
    super.initState();
    controller.getTeam();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<MyTeamController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTeamController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Maning Jamoam",
              style: CustomStyles.pageTitle,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  !controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            FootballFieldWidget(
                                players: controller.team.players!,
                                function: controller.selectPlayer),
                            PlayersCardWidget2(
                                players: controller.selectivePlayers,
                                function: controller.assignPlayer)
                          ],
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
