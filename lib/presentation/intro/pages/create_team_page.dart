import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:football/presentation/intro/controllers/create_team_controller.dart';
import 'package:football/presentation/widgets/football_field_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../home/pages/statistics/pages/player_detail_page.dart';
import '../../widgets/custom_button.dart';

class CreateTeamPage extends StatefulWidget {
  const CreateTeamPage({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final controller = Get.find<CreateTeamController>();

  @override
  void initState() {
    super.initState();
    controller.createTeam();
    controller.getClubs();
    controller.searchPlayers("FORWARD");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateTeamController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Kamanda tering",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "BUDGET",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        Text(
                          controller.balance.ceilToDouble().toString(),
                          style: const TextStyle(
                              color: Color.fromRGBO(31, 222, 0, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Container(
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(31, 222, 0, 1),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      alignment: Alignment.center,
                      child: MaterialButton(
                        onPressed: () {
                          controller.autoFill();
                        },
                        child: const Text(
                          "Auto Fill",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CreateTeamWidget(
                      controller: controller,
                    ),
                    controller.isTeamReady
                        ? const SizedBox()
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                controller.isTeamFool < 11
                    ? const SizedBox()
                    : CustomButton(
                        text: "Davom etish",
                        onPress: () {
                          controller.saveTeamId();
                          controller.goToNextPage(widget.pageController);
                          controller.saveGameTactics();
                        }),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(color: Colors.grey, blurRadius: 10)
                            ]),
                        width: 200,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                          ? Text("All teams")
                                          : Text(club.teamName ?? "")));
                            },
                          ),
                          onChanged: (int? value) {
                            controller.onClubChange(value);
                          },
                        ),
                      )
                    ],
                  ),
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
                            borderRadius: BorderRadius.circular(10)),
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
                                var player = controller.playersDetails[index];
                                return DataRow(cells: [
                                  DataCell(Text("${index + 1}")),
                                  DataCell(GestureDetector(
                                    onTap: () {
                                      // controller.assignPlayer(
                                      //     convertToPlayerSelectionModel(
                                      //         player));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 130,
                                          child: Row(
                                            children: [
                                              if (player.jersey != null)
                                                CachedNetworkImage(
                                                  imageUrl: player.jersey!,
                                                  width: 30,
                                                  height: 30,
                                                  placeholder: (context, url) {
                                                    return Image.asset(
                                                        "assets/images/home/player_img.png");
                                                  },
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                            "assets/images/home/player_img.png",
                                                            width: 54,
                                                          ),
                                                ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  player.name!,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.fade),
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
                                                    TextOverflow.ellipsis),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                  DataCell(Text("\$ ${player.price}")),
                                  DataCell(GestureDetector(
                                    child: const Icon(
                                      Icons.info_outline,
                                      color: Colors.green,
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return PlayerDetailPage(player: player);
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
                            values: [controller.minPrice, controller.maxPrice],
                            rangeSlider: true,
                            max: 10,
                            min: 0,
                            onDragCompleted:
                                (handlerIndex, lowerValue, upperValue) {
                              controller.onPriceChange(
                                  handlerIndex, lowerValue, upperValue);
                            },
                            handlerHeight: 12,
                            handlerWidth: 32,
                            trackBar: const FlutterSliderTrackBar(
                                activeTrackBar: BoxDecoration(
                                    color: Color.fromRGBO(31, 222, 0, 1))),
                            handler: FlutterSliderHandler(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(31, 222, 0, 1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            rightHandler: FlutterSliderHandler(
                              child: Container(
                                width: 32,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(31, 222, 0, 1),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10)),
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
          ),
        ),
      );
    });
  }
}
