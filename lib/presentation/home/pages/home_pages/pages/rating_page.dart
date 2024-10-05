import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/img_roots.dart';
import '../controllers/transfer_page_controller.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final controllerTable = Get.find<TransferPageController>();

  @override
  void initState() {
    super.initState();
    //  controller.getRating();
    controllerTable.getStanding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Reyting".tr,
          style: CustomStyles.appBarStyle,
        ),
        leading: IconButton(
          onPressed: () {
//   Navigator.pop(context);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Positioned(
              top: 0,
              child: Image.asset(
                ImgRoots.bg3,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          GetBuilder<TransferPageController>(builder: (_) {
            return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                  //padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.lGrey,
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
                      headingRowColor:
                          WidgetStateProperty.all(Colors.white,),
                      dataRowHeight: 40,
                      columnSpacing: 14,
                      dividerThickness:0,
                      decoration:BoxDecoration(
                        color: AppColors.lGrey,
                      ),
                      columns: [
                        DataColumn(
                            label: Text(
                          "Pos".tr,
                          style: CustomStyles.dataTitle!.copyWith(color: AppColors.purple),
                        )),
                        DataColumn(
                            label: Text(
                          "Klub".tr,
                          style: CustomStyles.dataTitle!.copyWith(color: AppColors.purple),
                        )),
                        DataColumn(
                            label: Text(
                          "W".tr,
                          style: CustomStyles.dataTitle!.copyWith(color: AppColors.purple),
                        )),
                        DataColumn(
                            label: Text(
                          "D",
                          style: CustomStyles.dataTitle!.copyWith(color: AppColors.purple),
                        )),
                        DataColumn(
                            label: Text(
                          "L",
                          style: CustomStyles.dataTitle!.copyWith(color: AppColors.purple),
                        )),
                        DataColumn(
                            label: Text(
                          "Point",
                          style: CustomStyles.dataTitle!.copyWith(color: AppColors.purple),
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
                                  return  AppColors.lGrey;
                                },
                              ),
                              cells: [
                                DataCell(Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(2),
                                      padding: EdgeInsets.all(20),
                                      width: 5,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft:
                                                  Radius.circular(10)),
                                          color: AppColors.baseColor),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text((index + 1).toString(),
                                          style: CustomStyles.dataTitle!
                                              .copyWith(color: Colors.black)),
                                    ),
                                  ],
                                )),
                                DataCell(GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // if (player.countryName !=
                                              //     null)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: player.teamBadge,
                                                  width: 23.w,
                                                  height: 27.h,
                                                  placeholder:
                                                      (context, url) {
                                                    return SizedBox();
                                                  },
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          SizedBox(),
                                                ),
                                              ),
                                              Text(
                                                player.teamName,
                                                style: CustomStyles.dataTitle!
                                                    .copyWith(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                        overflow: TextOverflow
                                                            .fade),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                DataCell(Text(player.overallLeagueW,
                                    style: CustomStyles.dataTitle!
                                        .copyWith(color: Colors.black))),
                                DataCell(Text(player.overallLeagueD,
                                    style: CustomStyles.dataTitle!
                                        .copyWith(color: Colors.black))),
                                DataCell(Text(player.overallLeagueL,
                                    style: CustomStyles.dataTitle!
                                        .copyWith(color: Colors.black))),
                                DataCell(Text(player.overallLeaguePTS,
                                    style: CustomStyles.dataTitle!
                                        .copyWith(color: Colors.black))),
                              ]);
                        },
                      ),
                    ),
                  ),
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
          })

          // Column(
          //   children: [
          //     _buildBlurredHeader(),
          //     _buildBlurredHeader(),
          //     _buildBlurredHeader(),
          //   ],
          // ),
          // TabBarView(
          //   children: [
          //     Column(
          //       children: [
          //         Expanded(
          //           flex: 2,
          //           child: _buildLeaguesList(controller1),
          //         ),
          //         Expanded(
          //           flex: 1,
          //           child: _buildCreateJoinButtons(),
          //         ),
          //       ],
          //     ),
          //     const ExtraLeaguesPage(),
          //   ],
          // ),
        ],
      ),
    );
  }
}
