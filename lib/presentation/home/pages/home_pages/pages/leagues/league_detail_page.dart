import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/league_detail_page_controller.dart';
import 'package:football/presentation/widgets/ranking_table_widget.dart';
import 'package:get/get.dart';

class LeagueDetailPage extends StatefulWidget {
  final String id;

  const LeagueDetailPage({super.key, required this.id});

  @override
  State<LeagueDetailPage> createState() => _LeagueDetailPageState();
}

class _LeagueDetailPageState extends State<LeagueDetailPage> {
  final controller = Get.find<LeagueDetailPageController>();

  @override
  void initState() {
    super.initState();
    controller.getLeagueDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeagueDetailPageController>(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            title: Text(controller.league?.name ?? ""),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 5,
                      offset: Offset(0, 2))
                ]),
            width: double.infinity,
            child: SoccerRankingTable(
              teams: controller.team,
            ),
          ));
    });
  }
}
