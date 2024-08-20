import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/team_detail_page_controller.dart';
import 'package:football/presentation/widgets/team_name_widget.dart';
import 'package:get/get.dart';

import '../../../../../widgets/football_field_widget.dart';

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
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        TeamNameWidget(
                          icon: controller.team.logo,
                          name: controller.team.name,
                        ),
                        FootballFieldWidget(
                          players: controller.players,
                          function: () {},
                        ),
                      ],
                    )
            ],
          ),
        ),
      );
    });
  }
}
