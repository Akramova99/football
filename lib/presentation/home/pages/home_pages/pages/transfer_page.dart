import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
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
    controller.searchPlayers();
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
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!controller.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
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
                            const SizedBox(
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
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TeamNameWidget(
                            icon: controller.teamIcon,
                            name: controller.teamName ?? ""),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TransferFootballField(
                          controller: controller,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: PlayerTransferCard(
                            players: controller.selectivePlayers,
                            function: () {}),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      if (controller.playerToBuy.isNotEmpty)
                        Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              controller.isLoadingPLayer
                                  ? CircularProgressIndicator()
                                  : Container(
                                height: 500,
                                      width: double.infinity,
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
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
                                          columnSpacing: 0,
                                          columns: const [
                                            DataColumn(label: Text("#")),
                                            DataColumn(
                                                label: Text("Oyinchilar")),
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
                                                DataCell(SizedBox(
                                                  width: 120,
                                                  child: Row(
                                                    children: [
                                                      // if (player.jersey == null)
                                                      //   Image.network(
                                                      //     player.jersey!,
                                                      //     width: 30,
                                                      //     height: 30,
                                                      //   ),
                                                      SizedBox(
                                                        width:100,
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
                                                )),
                                                DataCell(
                                                    Text("\$ ${player.price}")),
                                                const DataCell(Icon(
                                                  Icons.info_outline,
                                                  color: Colors.green,
                                                )),
                                              ]);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.all(10),
                                      child: DropdownButton<int>(
                                        underline: SizedBox(),
                                        elevation: 0,
                                        value: controller.positionIndex,
                                        items: List<
                                            DropdownMenuItem<int>>.generate(
                                          4,
                                          (int index) => DropdownMenuItem<int>(
                                            value: index,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                controller.listPosition[index],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    // Color of the items when displayed in the dropdown
                                                    fontSize: 14,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onChanged: (index) {
                                          controller.onPositionChange(index);
                                        },
                                        icon: const Icon(null,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.all(10),
                                      child: DropdownButton<int>(
                                        underline: SizedBox(),
                                        value: controller.pointsIndex,
                                        items: List<
                                            DropdownMenuItem<int>>.generate(
                                          2,
                                          (int index) => DropdownMenuItem<int>(
                                            value: index,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                controller.listPoints[index],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  // Color of the items when displayed in the dropdown
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onChanged: (index) {
                                          controller.onPointsChange(index);
                                        },
                                        icon: const Icon(null,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
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
                                          jump: true,
                                          values: const [0, 100],
                                          rangeSlider: true,
                                          max: 100,
                                          min: 0,
                                          onDragging: (handlerIndex, lowerValue,
                                              upperValue) {
                                            controller.onPriceChange(
                                                handlerIndex,
                                                lowerValue,
                                                upperValue);
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
                                                color: Color.fromRGBO(
                                                    31, 222, 0, 1),
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
                                                      BorderRadius.circular(
                                                          10)),
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
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: CustomButton(
                                  onPress: () {
                                    controller.searchPlayers();
                                  },
                                  text: 'Qidirish',
                                ),
                              )
                            ],
                          ),
                        )
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
