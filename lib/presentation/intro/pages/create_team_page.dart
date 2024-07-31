import 'package:flutter/material.dart';
import 'package:football/presentation/intro/controllers/create_team_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/presentation/widgets/football_field_widget.dart';
import 'package:football/presentation/widgets/players_card_widget.dart';
import 'package:football/presentation/widgets/tactics_menu_button.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class CreateTeamPage extends StatefulWidget {
  const CreateTeamPage({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final controller = Get.find<CreateTeamController>();

  @override
  void initState() {
    super.initState();
    controller.getPlayer();
    controller.createTeam();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateTeamController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Kamanda tering",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TacticsMenuButton(
                        controller: controller,
                      ),
                    ],
                  ),
                ),
                CreateTeamWidget(
                  controller: controller,
                ),
                const SizedBox(
                  height: 5,
                ),
                controller.isTeamFool < 11
                    ? PlayersCardWidget(
                        players: controller.selectivePlayer,
                        function: controller.assignPlayer,
                      )
                    : CustomButton(
                        text: "Save team",
                        onPress: () {
                          controller.saveTeamId();
                          controller.assignReservePlayers();
                          controller.goToNextPage(widget.pageController);

                        })
              ],
            ),
          ),
        ),
      );
    });
  }
}
