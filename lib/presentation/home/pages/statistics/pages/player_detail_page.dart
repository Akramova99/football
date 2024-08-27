import 'package:flutter/material.dart';
import 'package:football/presentation/widgets/player_table_widget.dart';
import 'package:get/get.dart';

import '../../../../../models/team_model.dart';
import '../controllers/player_detail_controller.dart';

class PlayerDetailPage extends StatefulWidget {
  const PlayerDetailPage({super.key, required this.player});

  final Player player;

  @override
  State<PlayerDetailPage> createState() => _PlayerDetailPageState();
}

class _PlayerDetailPageState extends State<PlayerDetailPage> {
  final controller = Get.find<PlayerDetailController>();

  @override
  void initState() {
    super.initState();
    controller.getPlayerDetails(widget.player.id!);
    controller.getPlayerHistoryDetails(widget.player.id!);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerDetailController>(builder: (_) {
      return DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(0, 185, 0, 1),
            leading: const Icon(null),
            actions: [
              GestureDetector(
                child: Image.asset(
                  "assets/images/home/cancel_icon.png",
                  height: 40,
                  width: 40,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 10,
              )
            ],
            title: const Text(
              "Player profile",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          body: controller.isLoading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                )
              : Column(
                  children: [
                    Container(
                      color: const Color.fromRGBO(51, 231, 51, 1),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 90,
                              child: controller.modelCurrent!.player?.jersey !=
                                      null
                                  ? Image.network(
                                      controller.modelCurrent!.player!.jersey!,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 3,
                                        child: Text(
                                          "NAME: ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          controller
                                              .modelCurrent!.player!.name!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 3,
                                        child: Text(
                                          "CLUB: ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          controller
                                              .modelCurrent!.player!.clubName!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 3,
                                        child: Text(
                                          "PRICE: ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "\$${controller.modelCurrent!.player!.price.toString()}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      indicatorColor: Colors.green,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          height: 57,
                          child: Text(
                            "Summary",
                            style: TextStyle(
                                fontSize: 20,
                                color: controller.pageIndex == 0
                                    ? Colors.green
                                    : Colors.black),
                          ),
                        ),
                        Tab(
                            height: 57,
                            child: Text(
                              "History",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: controller.pageIndex == 1
                                      ? Colors.green
                                      : Colors.black),
                            )),
                      ],
                      onTap: (index) {
                        controller.onPageChange(index);
                      },
                    ),
                    controller.modelCurrent != null
                        ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            width: 300,
                            child: PlayerStats(
                              model: controller.modelCurrent!,
                            ))
                        : SizedBox(),
                    Expanded(
                        child: controller.pageIndex == 0
                            ? PlayerDataTable(
                                model: controller.current,
                              )
                            : PlayerDataTable(
                                model: controller.history,
                              )),
                  ],
                ),
        ),
      );
    });
  }
}
