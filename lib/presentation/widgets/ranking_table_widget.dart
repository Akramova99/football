import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../models/team_reyting_model.dart';
import '../../utils/constants/app_colors.dart';
import '../home/pages/home_pages/controllers/calendar_page_controller.dart';
import '../home/pages/home_pages/controllers/rating_page_controller.dart';
import '../home/pages/home_pages/controllers/transfer_page_controller.dart';
import '../home/pages/settings_pages/controllers/profile_page_controller.dart';

class SoccerRankingTable extends StatefulWidget {
  final List<TeamRatingModel> teams;
  final bool isSeeAll;

  const SoccerRankingTable(
      {super.key, required this.teams, required this.isSeeAll});

  @override
  State<SoccerRankingTable> createState() => _SoccerRankingTableState();
}

class _SoccerRankingTableState extends State<SoccerRankingTable> {
  final controller = Get.find<RatingPageController>();
  final controllerTable = Get.find<TransferPageController>();
  final profile = Get.find<ProfilePageController>();

  @override
  void initState() {
    super.initState();
    profile.getData();
    controller.getRating();
    controllerTable.getStanding();
    Logger().e(controllerTable.standing.length);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransferPageController>(builder: (_) {
      return SingleChildScrollView(
          child: Column(
           children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.lBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 25),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                Text(
                  "Umumiy reyting".tr,
                  style: CustomStyles.dataTitle,
                ),
                widget.isSeeAll
                    ? TextButton(
                        onPressed: () {
                          Get.find<CalendarPageController>()
                              .callAllRating(context);
                        },
                        child: Text(
                          "Hammasini ko\'rish".tr,
                          style: CustomStyles.dataTitle!.copyWith(color: AppColors.baseColor),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.lBlack,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(AppColors.lBlack),
              dataRowHeight: 60,
              columnSpacing: 10,
              columns: [
                DataColumn(
                    label: Text(
                  "Klub".tr,
                  style: CustomStyles.dataTitle,
                )),
                DataColumn(
                    label: Text(
                  "W".tr,
                  style: CustomStyles.dataTitle,
                )),
                DataColumn(
                    label: Text(
                  "D",
                  style: CustomStyles.dataTitle,
                )),
                DataColumn(
                    label: Text(
                  "L",
                  style: CustomStyles.dataTitle,
                )),
                DataColumn(
                    label: Text(
                  "Point",
                  style: CustomStyles.dataTitle,
                )),
              ],
              rows: List.generate(
                controllerTable.standing.length,
                (index) {
                  var player = controllerTable.standing[index];

                  return DataRow(
                      color: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          // Set the color of the row to black
                          return AppColors.lBlack;
                        },
                      ),
                      cells: [
                        DataCell(GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150.w,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        "assets/images/home/circle.png",
                                        width: 8,
                                        fit: BoxFit.cover,
                                      ),
                                      // if (player.countryName !=
                                      //     null)
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(4.0),
                                          child:
                                          CachedNetworkImage(
                                            imageUrl: player.teamBadge,
                                            width: 23.w,
                                            height: 27.h,
                                            placeholder: (context, url) {
                                            return SizedBox();
                                            },
                                            errorWidget: (context, url, error) =>      SizedBox(),
                                          ),
                                        ),
                                      SizedBox(
                                        width: 110.w,
                                        child: Text(
                                          player.teamName,
                                          style: CustomStyles.dataTitle!
                                              .copyWith(
                                                  overflow: TextOverflow.fade),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        DataCell(Text(player.overallLeagueW,
                            style: CustomStyles.dataTitle)),
                        DataCell(Text(player.overallLeagueD,
                            style: CustomStyles.dataTitle)),
                        DataCell(Text(player.overallLeagueL,
                            style: CustomStyles.dataTitle)),
                        DataCell(Text(player.overallLeaguePTS,
                            style: CustomStyles.dataTitle)),
                      ]);
                },
              ),
            ),
          ),
        ],
      )
          // ClipRRect(
          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
          //   child: DataTable(
          //     headingRowColor:  WidgetStateProperty.resolveWith<Color?>(
          //           (Set<WidgetState> states) {
          //         // Set the color of the row to black
          //         return AppColors.lBlack;
          //       },
          //     ),
          //     columnSpacing: 10,
          //     border: TableBorder(
          //       bottom: BorderSide(color: Colors.grey.shade100, width: 0.5),
          //       horizontalInside: BorderSide(color: Colors.grey.shade100, width: 0.5),
          //     ),
          //     clipBehavior: Clip.hardEdge,
          //     dividerThickness: 1,
          //     columns:  [
          //       DataColumn(label: Text('#',style: CustomStyles.dataTitle,)),
          //       DataColumn(
          //         label: Text('Jamoalar',style: CustomStyles.dataTitle,),
          //       ),
          //       DataColumn(label: Text('M',style: CustomStyles.dataTitle,)),
          //       DataColumn(label: Text('PTS',style: CustomStyles.dataTitle,)),
          //     ],
          //     rows: List.generate(
          //       widget.teams.length,
          //           (index) {
          //         final team = widget.teams[index];
          //         return DataRow(
          //           onLongPress: () {
          //             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          //               return TeamDetailPage(id: team.id ?? 0);
          //             }));
          //           },
          //           color: WidgetStateProperty.resolveWith<Color?>(
          //                 (Set<WidgetState> states) {
          //               // Set the color of the row to black
          //               return AppColors.lBlack;
          //             },
          //           ),
          //           cells: [
          //             DataCell(Text((index + 1).toString(), style: TextStyle(color: Colors.white))),
          //             DataCell(Row(
          //               children: [
          //                 SizedBox(
          //                   height: 25,
          //                   width: 25,
          //                   child: team.logo != null
          //                       ?ClipOval(
          //                     child: CachedNetworkImage(
          //                       width: 54,
          //                       height: 54,
          //                       fit: BoxFit.cover,
          //                       // Bu rasmning to'liq joylashishiga yordam beradi
          //                       placeholder: (context, url) {
          //                         print("+++++++++++++++++++++++");
          //                         return Stack(
          //                           children: [
          //                             Image.asset(
          //                               "assets/images/home/player_img.png",
          //                               width: 54,
          //                               height: 54,
          //                             ),
          //                           ],
          //                         );
          //                       },
          //                       errorWidget: (context, url, error) => Image.asset(
          //                         "assets/images/home/player_img.png",
          //                         width: 54,
          //                         height: 54,
          //                       ),
          //                       imageUrl:
          //                       profile.user.image??'http://46.101.131.127:8080/api/v1/files/league_eeb750ce-6ce1-4622-a713-5bc6e826bce0.png',
          //                     ),
          //                   )
          //                       : Image.asset(teamLogos[Random().nextInt(teamLogos.length)]),
          //                 ),
          //                 const SizedBox(width: 5),
          //                 SizedBox(
          //                   width: 120,
          //                   child:  Text(
          //                     textAlign: TextAlign.center,
          //                     index==0?    profile.name?? "":team.name??"",
          //                     style: const TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 16,
          //                         fontWeight: FontWeight.w700),
          //                   ),
          //                 ),
          //               ],
          //             )),
          //             DataCell(Text(team.currentScore!.toString(), style: TextStyle(color: Colors.white))),
          //             DataCell(Text(team.totalScore!.toString(), style: TextStyle(color: Colors.white))),
          //           ],
          //         );
          //       },
          //     ),
          //   )
          //   ,
          // ),
          );
    });
  }
}
