import 'package:flutter/material.dart';
import 'package:football/presentation/intro/controllers/capitan_selection_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../widgets/football_field_widget.dart';

class CapitanSelectionPage extends StatefulWidget {
  const CapitanSelectionPage({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<CapitanSelectionPage> createState() => _CapitanSelectionPageState();
}

class _CapitanSelectionPageState extends State<CapitanSelectionPage> {
  final controller = Get.find<CapitanSelectionController>();

  @override
  void initState() {
    super.initState();
    controller.getTeamId();
    controller.getTeam();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CapitanSelectionController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CapitanSelectionController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Capitan tanlang",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: controller.teamId != null
              ? Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      controller.isDataReady
                          ? Column(
                              children: [
                                // FootballFieldWidget(
                                //   players: controller.players,
                                //   function: controller.selectPlayer,
                                // ),
                                CapitanSelectionWidget(controller: controller),
                                const SizedBox(height: 5),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator()),
                      controller.capitan != null
                          ? CustomButton(
                              text: "Davom etish",
                              onPress: () {
                                controller.saveCapitan(widget.pageController);
                              })
                          : const SizedBox()
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(10),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sizda jamoa mavjud emas",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
