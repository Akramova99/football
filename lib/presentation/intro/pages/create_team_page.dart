import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:football/presentation/intro/controllers/create_team_controller.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:football/presentation/widgets/football_field_widget.dart';
import 'package:football/utils/constants/img_roots.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/converter.dart';
import '../../home/pages/statistics/controllers/statistics_page_controller.dart';
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
  final controller2 = Get.find<StatisticsPageController>();
  final statisticController = Get.find<StatisticsPageController>();

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
              "O'zingizning jamoangizni yig'ing",
              style: CustomStyles.appBarStyle,
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Image.asset(
                ImgRoots.bg1,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "BUDGET",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Row(
                                children: [
                                  Text(
                                    controller.balance
                                        .ceilToDouble()
                                        .toString(),
                                    style: const TextStyle(
                                        color: AppColors.HRed,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset(
                                    ImgRoots.budget,
                                    height: 24,
                                    width: 24,
                                    color: AppColors.baseColor,
                                  )
                                ],
                              )
                            ],
                          ),
                          Container(
                            width: 100,
                            height: 25,
                            decoration: BoxDecoration(
                              color: AppColors.HRed.withOpacity(0.55),
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
                    controller.isTeamFool < 11
                        ? const SizedBox()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: CustomButton(
                                text: "Davom etish",
                                onPress: () {
                                  controller.saveTeamId();
                                  controller
                                      .goToNextPage(widget.pageController);
                                  controller.saveGameTactics();
                                }, color: AppColors.baseColor,),
                          ),
                    if (controller.isLoadingPLayer) const CircularProgressIndicator() else
                      Container(

                            height: 500,

                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: AppColors.tableColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: SizedBox(
                             // width:370,
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: DataTable(
                                    headingRowColor: WidgetStateProperty.all(
                                        AppColors.tableColor),
                                    dataRowHeight: 60,
                                    columnSpacing: 20,
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        "#",
                                        style: CustomStyles.dataTitle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Oyinchilar",
                                        style: CustomStyles.dataTitle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Narxi",
                                        style: CustomStyles.dataTitle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Info",
                                        style: CustomStyles.dataTitle,
                                      )),
                                    ],
                                    rows: List.generate(
                                      controller.playersDetails.length,
                                      (index) {
                                        var player =
                                              controller.playersDetails[index];
                                        return DataRow(

                                            color: WidgetStateProperty.all(
                                                AppColors.tableColor),
                                            cells: [
                                              DataCell(Text(
                                                "${index + 1}",
                                                style: CustomStyles.dataTitle,
                                              )),
                                              DataCell(GestureDetector(
                                                onTap: () {
                                                  controller.assignPlayer(
                                                      convertToPlayerSelectionModel(
                                                          player));
                                                },
                                                child: Column(

                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(

                                                      children: [
                                                        if (player.jersey != null)
                                                          CachedNetworkImage(
                                                            imageUrl:
                                                                player.jersey!,
                                                            width: 30,
                                                            height: 30,
                                                            placeholder:
                                                                (context, url) {
                                                              print(
                                                                  "+++++++++++++++++++++++");
                                                              return Stack(
                                                                children: [
                                                                  Image.asset(
                                                                      "assets/images/home/player_img.png")
                                                                ],
                                                              );
                                                            },
                                                            errorWidget: (context,
                                                                    url, error) {
                                                              print(
                                                                  "+++++++++++++++++++++++$error");
                                                              print(
                                                                  "+++++++++++++++++++++++$url");
                                                              return Image.asset(
                                                              "assets/images/home/player_img.png",
                                                              width: 54,
                                                            );
                                                            },
                                                          ),
                                                        Text(
                                                          player.name!.length > 11
                                                              ? player.name!.substring(0, 11) + '...'
                                                              : player.name!,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "Poppins",
                                                          ),
                                                        ),

                                                      ],

                                                    ),
                                                    Text(
                                                      "  ${player.clubName ?? ""}".length > 14
                                                          ? "  ${player.clubName ?? ""}".substring(0, 14) + '...'
                                                          : "  ${player.clubName ?? ""}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              )),
                                              DataCell(Text(
                                                "\$ ${player.price}",
                                                style: CustomStyles.dataTitle,
                                              )),
                                              DataCell(GestureDetector(
                                                child: const Icon(
                                                  Icons.info_outline,
                                                  color: Colors.green,
                                                ),
                                                onTap: () {
                                                  Logger().w(player.id);
                                                  statisticController.getPlayers(player.id!);
                                                  statisticController
                                                      .callPLayerDetailPage(statisticController.players!, context);
                                                },
                                              )),
                                            ]);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                     SizedBox(
                      height: 25.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Min\n${controller.minPrice}\$",
                                  style: const TextStyle(fontSize: 10),
                                ),
                                //  const SizedBox(width: 5),
                                // Increase the slider's width for more flexibility
                                Container(
                                  width: 190.w,
                                  height: 40.h,
                                  child: FlutterSlider(
                                    //  axis: Axis.horizontal,
                                    values: [
                                      controller.minPrice,
                                      controller.maxPrice,
                                    ],
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
                                      inactiveTrackBar: BoxDecoration(
                                        color: AppColors.red,
                                      ),
                                      activeTrackBar: BoxDecoration(
                                        color: AppColors.HRed,
                                      ),
                                    ),
                                    handler: FlutterSliderHandler(
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          color: AppColors.HRed,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    rightHandler: FlutterSliderHandler(
                                      child: Container(
                                        width: 32,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: AppColors.HRed,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Max\n${controller.maxPrice}\$",
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          // Fix dropdown layout issue
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppColors.HRed,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, blurRadius: 10)
                              ],
                            ),
                            padding: const EdgeInsets.only(left: 10),
                            margin: const EdgeInsets.only(right: 10),
                            child: DropdownButton<int>(
                              underline: const SizedBox(),
                              value: controller.clubsIndex,
                              menuWidth: 200,
                              items: List.generate(
                                controller.clubs.length,
                                (index) {
                                  var club = controller.clubs[index];
                                  return DropdownMenuItem(
                                    value: index,
                                    child: Text(
                                      index == 0
                                          ? "Clubs"
                                          : club.teamName != null
                                              ? club.teamName!.split(" ").first
                                              : "",
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  );
                                },
                              ),
                              onChanged: (int? value) {
                                controller.onClubChange(value);
                              },
                              isExpanded:
                                  false, // Ensure the dropdown expands to fit the text
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
