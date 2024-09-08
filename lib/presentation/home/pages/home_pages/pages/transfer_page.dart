import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:football/presentation/home/pages/statistics/pages/player_detail_page.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/styles.dart';
import '../../../../widgets/change_player_football_field.dart';

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
    controller.getTransferSummary();
    controller.searchPlayers("Forward".toUpperCase());
    controller.getClubs();
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
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (!controller.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 18,
                          color: const Color.fromRGBO(97, 255, 97, 1),
                          alignment: Alignment.center,
                          child: Text(
                            "MatchWeek ${controller.matchWeek.weekNumber ?? ""} Confirm by ${controller.deadline}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: double.infinity,
                          height: 65,
                          color: const Color.fromRGBO(216, 255, 216, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text("Budget"),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    "${controller.transferSummaryModel.balance?.ceilToDouble() ?? ""}",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(31, 222, 0, 1),
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("CL"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "${controller.transferSummaryModel.selectionLimit ?? ""}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("FT"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "${controller.transferSummaryModel.freeTransfers ?? ""}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("ET"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "${controller.transferSummaryModel.paidTransfers ?? "-"}"),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/transfer/money_img.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "${controller.transferSummaryModel.paidTransfers}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(2),
                          width: 200,
                          height: 25,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 185, 0, 1),
                              borderRadius: BorderRadius.circular(7)),
                          child: MaterialButton(
                            textColor: Colors.white,
                            onPressed: () {
                              controller.goToBalancePage(context);
                            },
                            child: const Text(
                              "BUY UNLIMITED TRANSFERS",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Text(
                            "Jaomam ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            controller.teamName,
                            style: const TextStyle(
                                color: Colors.green, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TransferFootballField(
                        controller: controller,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (controller.playerToBuy.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey, blurRadius: 10)
                                      ]),
                                  width: 200,
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<int>(
                                    underline: const SizedBox(),
                                    value: controller.clubsIndex,
                                    items: List.generate(
                                      controller.clubs.length,
                                      (index) {
                                        var club = controller.clubs[index];
                                        return DropdownMenuItem(
                                            value: index,
                                            child: SizedBox(
                                                width: 150,
                                                child: index == 0
                                                    ? const Text("All teams")
                                                    : Text(
                                                        club.teamName ?? "")));
                                      },
                                    ),
                                    onChanged: (int? value) {
                                      controller.onClubChange(value);
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            controller.isLoadingPLayer
                                ? const CircularProgressIndicator()
                                : Container(
                                    height: 500,
                                    width: double.infinity,
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      child: DataTable(
                                        dataRowHeight: 60,
                                        columnSpacing: 20,
                                        columns: const [
                                          DataColumn(label: Text("#")),
                                          DataColumn(label: Text("Oyinchilar")),
                                          DataColumn(label: Text("Narxi")),
                                          DataColumn(label: Text("Info")),
                                        ],
                                        rows: List.generate(
                                          controller.playersDetails.length,
                                          (index) {
                                            var player = controller
                                                .playersDetails[index];
                                            return DataRow(cells: [
                                              DataCell(Text("${index + 1}")),
                                              DataCell(GestureDetector(
                                                onTap: () {
                                                  controller.buyPlayer(player);
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 130,
                                                      child: Row(
                                                        children: [
                                                          if (player.jersey !=
                                                              null)
                                                            CachedNetworkImage(
                                                              imageUrl: player
                                                                  .jersey!,
                                                              width: 30,
                                                              height: 30,
                                                              placeholder:
                                                                  (context,
                                                                      url) {
                                                                return Image.asset(
                                                                    "assets/images/home/player_img.png");
                                                              },
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                      "assets/images/home/player_img.png"),
                                                            ),
                                                          SizedBox(
                                                            width: 100,
                                                            child: Text(
                                                              player.name!,
                                                              style: const TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 130,
                                                      child: Text(
                                                        "  ${player.clubName ?? ""}",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                              DataCell(
                                                  Text("\$ ${player.price}")),
                                              DataCell(GestureDetector(
                                                child: const Icon(
                                                  Icons.info_outline,
                                                  color: Colors.green,
                                                ),
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                    return PlayerDetailPage(
                                                        player: player);
                                                  }));
                                                },
                                              )),
                                            ]);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text("Min\n${controller.minPrice}\$"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      child: FlutterSlider(
                                        axis: Axis.horizontal,
                                        values: [
                                          controller.minPrice,
                                          controller.maxPrice
                                        ],
                                        rangeSlider: true,
                                        max: 10,
                                        min: 0,
                                        onDragCompleted: (handlerIndex,
                                            lowerValue, upperValue) {
                                          controller.onPriceChange(handlerIndex,
                                              lowerValue, upperValue);
                                        },
                                        handlerHeight: 12,
                                        handlerWidth: 32,
                                        trackBar: const FlutterSliderTrackBar(
                                            activeTrackBar: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    31, 222, 0, 1))),
                                        handler: FlutterSliderHandler(
                                          child: Container(
                                            width: 12,
                                            height: 12,
                                            decoration: const BoxDecoration(
                                              color:
                                                  Color.fromRGBO(31, 222, 0, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        rightHandler: FlutterSliderHandler(
                                          child: Container(
                                            width: 32,
                                            height: 12,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    31, 222, 0, 1),
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Max\n${controller.maxPrice}\$"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                )
            ],
          ),
        ),
      );
    });
  }
}
