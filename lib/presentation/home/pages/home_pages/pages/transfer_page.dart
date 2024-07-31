import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/styles.dart';
import '../../../../widgets/football_field_widget.dart';
import '../../../../widgets/players_card_widget.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {

  final controller = Get.find<TransferPageController>();


  @override
  void initState() {
    super.initState();
    controller.getTeam();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<TransferPageController>();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransferPageController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Transfer",
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
    });
  }
}
