import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/points_page_controller.dart';
import 'package:football/presentation/widgets/football_field_widget.dart';
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
    return GetBuilder<PointsPageController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Ochkolar",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(),
              FootballFieldWidget()],
          ),
        ),
      );
    });
  }
}
