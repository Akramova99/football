import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/my_team_controller.dart';
import 'package:football/presentation/widgets/players_card_widget.dart';
import 'package:football/presentation/widgets/team_name_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../widgets/change_player_football_field.dart';

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
  Widget build(BuildContext context) {
    return GetBuilder<MyTeamController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Mening Jamoam",
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
                            TeamNameWidget(
                                icon: controller.teamIcon,
                                name: controller.teamName ?? ""),
                            ChangePlayerFootballField(
                              controller: controller,
                            ),
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
