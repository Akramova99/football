import 'package:flutter/material.dart';
import 'package:football/presentation/intro/controllers/create_team_controller.dart';
import 'package:football/presentation/widgets/football_field_widget.dart';
import 'package:football/presentation/widgets/players_card_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class CreateTeamPage extends StatefulWidget {
  const CreateTeamPage({super.key});

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final controller = Get.find<CreateTeamController>();

  @override
  void initState() {
    super.initState();
    controller.getPlayer();
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
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [buildDrop(context)],
                  ),
                ),
                FootballFieldWidget(),
                SizedBox(
                  height: 5,
                ),
                PlayersCardWidget(
                  players: controller.players,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildDrop(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<int>(
        value: 1,
        onChanged: (index) {},
        style: const TextStyle(
          color: Colors.black,
          // Color of the items when displayed in the dropdown
          fontSize: 20,
        ),
        dropdownColor: Colors.white,
        // Background color of the dropdown
        selectedItemBuilder: (BuildContext context) {
          return [
            Center(
              child: Text(
                "1",
                style: const TextStyle(
                  color: Colors.white,
                  // Color of the selected item when closed
                  fontSize: 20,
                ),
              ),
            )
          ];
        },
        items: [],
        icon: const Icon(null, color: Colors.white),
      ),
    );
  }
}
