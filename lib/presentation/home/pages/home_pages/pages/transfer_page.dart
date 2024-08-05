import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/styles.dart';
import '../../../../widgets/change_player_football_field.dart';
import '../../../../widgets/players_card_widget.dart';
import '../../../../widgets/team_name_widget.dart';

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
    controller.getBalance();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              const Text("Jamoam"),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                controller.teamName ?? "",
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 14),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              controller.teamIcon != null
                                  ? Image.network(
                                      controller.teamIcon!,
                                      width: 24,
                                    )
                                  : const SizedBox(),
                              const Spacer(),
                              Text(
                                controller.balance ?? "",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.green),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "\$",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TeamNameWidget(
                              icon: controller.teamIcon,
                              name: controller.teamName ?? ""),
                          TransferFootballField(
                            controller: controller,
                          ),
                          PlayerTransferCard(
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
