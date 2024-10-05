import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/team_detail_page_controller.dart';
import 'package:football/presentation/widgets/points_player_widget.dart';
import 'package:football/presentation/widgets/team_name_widget.dart';
import 'package:get/get.dart';
import '../../../../../widgets/change_player_football_field.dart';

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              controller.isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        TeamNameWidget(
                          icon: controller.team.logo,
                          name: controller.team.name,
                        ),
                        TeamDetailWidget(
                          controller: controller,
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
              height: 423.h,          ),
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

    var goalKeeper = 2;

    list.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          goalKeeper,
          (i) => GestureDetector(
            child: PointsPlayerWidget(player: controller.players[0 + i]),
          ),
        )));

    var defender = 5;
    list.add(buildRow(defender, 1, goalKeeper));

    var midfielder = 5;
    list.add(buildRow(midfielder, 2, defender + goalKeeper));

    var forward = 3;
    list.add(buildRow(forward, 3, defender + midfielder + goalKeeper));
    return list;
  }

  buildRow(int playerNumber, int position, int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          playerNumber,
          (i) => GestureDetector(
            onTap: () {},
            child: PointsPlayerWidget(player: controller.players[index + i]),
          ),
        ));
  }
}
