import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/rating_page_controller.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../widgets/ranking_table_widget.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final controller = Get.find<RatingPageController>();

  @override
  void initState() {
    super.initState();
    controller.getRating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reyting",
          style: CustomStyles.pageTitle,
        ),
      ),
      body: GetBuilder<RatingPageController>(builder: (_) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            color: Colors.white,
          ),
          child: SoccerRankingTable(
            teams: controller.teams,
          ),
        );
      }),
    );
  }
}
