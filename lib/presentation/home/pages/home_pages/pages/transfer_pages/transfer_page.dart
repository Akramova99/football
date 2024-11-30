import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/pages/transfer_pages/transfer_clubs.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/img_roots.dart';
import '../../../../../../utils/constants/styles.dart';
import '../../../../../widgets/change_player_football_field.dart';
import '../../../settings_pages/controllers/profile_page_controller.dart';
import '../../../statistics/controllers/statistics_page_controller.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final controller = Get.find<TransferPageController>();
  final controller2 = Get.find<StatisticsPageController>();
  final profileController = Get.find<ProfilePageController>();

  @override
  void initState() {
    super.initState();
    controller.getTeam();
    controller.getTransferSummary();
    controller.searchPlayers();
    profileController.getData(); // En
    controller.getClubs();
    controller.getStanding();
  }
String selectClubName="";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransferPageController>(builder: (_) {
      int totalPlayers = controller.playersDetails.length;

// Counting the number of players with isPrimary set to true
      int primaryPlayersCount = controller.playersDetails
          .where((player) => player.isPrimary == true)
          .length;
      return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              ImgRoots.bg2,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20,
                            )),
                        Padding(
                          padding: EdgeInsets.only(right: 140.w),
                          child: Text(
                            "Transfer".tr,
                            style: CustomStyles.appBarStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
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
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              height: 109.h,
                              decoration: const BoxDecoration(
                                color: AppColors.statistic,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              padding: const EdgeInsets.all(
                                12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GetBuilder<ProfilePageController>(
                                        builder: (_) {
                                          return Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    const Color(0xff414158),
                                                radius: 25,
                                                // Adjust the radius to control the size of the avatar
                                                child: ClipOval(
                                                  child: CachedNetworkImage(
                                                    height: 45.h,
                                                    width: 41.w,
                                                    fit: BoxFit.cover,
                                                    // Ensures the image fills the circle
                                                    imageUrl: profileController
                                                            .user.image ??
                                                        "",
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      'assets/images/team/placeholder.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      'assets/images/team/placeholder.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Text(profileController.name ?? "",
                                                  style: CustomStyles
                                                      .appBarStyle
                                                      .copyWith(
                                                          color: Colors.white)),
                                            ],
                                          );
                                        },
                                      ),
                                      Row(
                                        children: [
                                          Text("${"Budget".tr}:",
                                              style: CustomStyles.dataTitle!
                                                  .copyWith(
                                                      color:
                                                          AppColors.textColor)),
                                          SizedBox(
                                            width: 9.h,
                                          ),
                                          Text(
                                            "${controller.transferSummaryModel.balance?.ceilToDouble() ?? ""}\$",
                                            style: const TextStyle(
                                                color: AppColors.cyan,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/team/hand.png",
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                          SizedBox(
                                            width: 10.h,
                                          ),
                                          Text(
                                            "${controller.transferSummaryModel.paidTransfers}",
                                            style: CustomStyles.dataTitle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              "CL",
                                              style: CustomStyles.dataTitle!
                                                  .copyWith(
                                                      color:
                                                          AppColors.textColor),
                                            ),
                                          ),
                                          Text(
                                            "${controller.transferSummaryModel.selectionLimit ?? ""}",
                                            style: CustomStyles.dataTitle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              "FT",
                                              style: CustomStyles.dataTitle!
                                                  .copyWith(
                                                      color:
                                                          AppColors.textColor),
                                            ),
                                          ),
                                          Text(
                                            "${controller.transferSummaryModel.freeTransfers ?? ""}",
                                            style: CustomStyles.dataTitle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              "ET",
                                              style: CustomStyles.dataTitle!
                                                  .copyWith(
                                                      color:
                                                          AppColors.textColor),
                                            ),
                                          ),
                                          Text(
                                            "${controller.transferSummaryModel.paidTransfers ?? "-"}",
                                            style: CustomStyles.dataTitle,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                            color: AppColors.cyan,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: MaterialButton(
                                          textColor: Colors.white,
                                          onPressed: () {
                                            controller.goToBalancePage(context);
                                          },
                                          child: Text(
                                            "Cheksiz Transfer sotib oling".tr,
                                            style: TextStyle(fontSize: 9),
                                            softWrap: true,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                  // Text(
                                  //   data["label"]!,
                                  //   style: const TextStyle(
                                  //       fontSize: 8,
                                  //       color: AppColors.textColor,
                                  //       fontFamily: "Poppins",
                                  //       fontWeight: FontWeight.w500),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TransferFootballField(
                            controller: controller,
                          ),
                        ),
                        if (controller.playerToBuy.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(5),
                            width: double.infinity,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                controller.isLoadingPLayer
                                    ? const CircularProgressIndicator()
                                    : Column(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: AppColors.tableColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25),
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //
                                                Text(
                                                  "Fudbol o\'yinchilari".tr,
                                                  style: CustomStyles.dataTitle,
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (BuildContext
                                                                    ctx) {
                                                      return TransferCubs(
                                                          transfer: controller);
                                                    }));
                                                  },
                                                  child: Text(
                                                    "Hammasini ko\'rish".tr,
                                                    style: CustomStyles
                                                        .dataTitle!
                                                        .copyWith(
                                                            color: AppColors
                                                                .baseColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 500.h,
                                            width: double.infinity,
                                            margin: EdgeInsets.only(bottom: 5),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: AppColors.tableColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              child: DataTable(
                                                headingRowColor:
                                                    WidgetStateProperty.all(
                                                        AppColors.tableColor),
                                                dataRowHeight: 60,
                                                columnSpacing: 60,
                                                columns: [
                                                  DataColumn(
                                                      label: Text(
                                                    "Klub".tr,
                                                    style:
                                                        CustomStyles.dataTitle,
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "Narxi".tr,
                                                    style:
                                                        CustomStyles.dataTitle,
                                                  )),
                                                ],
                                                rows: List.generate(
// Calculating the difference
//                                                   totalPlayers -
//                                                       primaryPlayersCount,
                                                  controller
                                                      .playersDetails.length,
                                                  (index) {
                                                    // var players = controller.playersDetails
                                                    //     .where((player) => player.isPrimary == false).toList();
                                                    // var player = players[index];
                                                    var player = controller
                                                        .playersDetails[index];
                                                    return DataRow(
                                                        color:
                                                            WidgetStateProperty
                                                                .resolveWith<
                                                                    Color?>(
                                                          (Set<WidgetState>
                                                              states) {
                                                            // Set the color of the row to black
                                                            return AppColors
                                                                .tableColor;
                                                          },
                                                        ),
                                                        cells: [
                                                          DataCell(
                                                              GestureDetector(
                                                            onTap: () {
                                                              Logger()
                                                                  .w("Bosildi");
                                                              //controller.selectPlayer(player);
                                                              controller
                                                                  .buyPlayer(
                                                                      player);
                                                              if (controller
                                                                  .isLoading2) {
                                                                controller
                                                                    .getTeam();
                                                              }
                                                            },
                                                            child: SizedBox(
                                                              //  color: Colors.red,
                                                              width: 150.w,
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/images/home/circle.png",
                                                                      width: 8,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    if (player
                                                                            .clubLogo !=
                                                                        null)
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              player.clubLogo!,
                                                                          width:
                                                                              23.w,
                                                                          height:
                                                                              27.h,
                                                                          placeholder:
                                                                              (context, url) {
                                                                            return Image.asset(
                                                                              "assets/images/home/player_img.png",
                                                                              width: 30.w,
                                                                              height: 30.h,
                                                                            );
                                                                          },
                                                                          errorWidget: (context, url, error) =>
                                                                              Image.asset(
                                                                            "assets/images/home/player_img.png",
                                                                            width:
                                                                                30.w,
                                                                            height:
                                                                                30.h,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    SizedBox(
                                                                      width:
                                                                          110.w,
                                                                      child:
                                                                          Text(
                                                                        player
                                                                            .name!,
                                                                        style: CustomStyles
                                                                            .dataTitle!
                                                                            .copyWith(overflow: TextOverflow.fade),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                          DataCell(Text(
                                                              "\$ ${player.price}",
                                                              style: CustomStyles
                                                                  .dataTitle)),
                                                        ]);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                                              style:
                                                  const TextStyle(fontSize: 10),
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
                                                onDragCompleted: (handlerIndex,
                                                    lowerValue, upperValue) {
                                                  controller.onPriceChange(
                                                      handlerIndex,
                                                      lowerValue,
                                                      upperValue);
                                                },
                                                handlerHeight: 12,
                                                handlerWidth: 32,
                                                trackBar:
                                                    const FlutterSliderTrackBar(
                                                  inactiveTrackBar:
                                                      BoxDecoration(
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppColors.HRed,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                rightHandler:
                                                    FlutterSliderHandler(
                                                  child: Container(
                                                    width: 32,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.HRed,
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "Max\n${controller.maxPrice}\$",
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Fix dropdown layout issue
                                      Container(
                                        //  width: 150,
                                        decoration: BoxDecoration(
                                          color: AppColors.HRed,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 10)
                                          ],
                                        ),
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: DropdownButton<int>(
                                          underline: const SizedBox(),
                                          value: controller.clubsIndex,
                                          menuWidth: 200,
                                          items: List.generate(
                                            controller.clubs.length,
                                            (index) {
                                              var club =
                                                  controller.clubs[index];
                                              selectClubName =club.teamName??"";
                                              return DropdownMenuItem(
                                                value: index,
                                                child: Row(
                                                  children: [
                                                    CachedNetworkImage(
                                                        imageUrl:
                                                            club.logo ?? "",
                                                        width: 23.w,
                                                        height: 27.h,
                                                        placeholder:
                                                            (context, url) {
                                                          return const SizedBox();
                                                        },
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const SizedBox()),
                                                    Text(
                                                      index == 0
                                                          ? "Clubs"
                                                          : club.teamName !=
                                                                  null
                                                              ? club.teamName!
                                                                  .split(" ")
                                                                  .first
                                                              : "",
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          onChanged: (int? value) {
                                            controller.onClubChange(selectClubName);
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
                          )
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
