import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../intro/controllers/create_team_controller.dart';
import '../pages/statistics/controllers/statistics_page_controller.dart';

class DropdownBut extends StatefulWidget {
  final String text;
  final bool isClub; // Ensure isClub is of type bool

  const DropdownBut({super.key, required this.text, required this.isClub});

  @override
  State<DropdownBut> createState() => _DropdownButState();
}

class _DropdownButState extends State<DropdownBut> {
  int positionIndex = 0; // For position dropdown
   // For position dropdown
  StatisticsPageController statisticsController =
      Get.find<StatisticsPageController>();

  @override
  void initState() {
    super.initState();
    statisticsController
        .fetchDefaultStatistics(); // Fetch default statistics on init
  }

  @override
  Widget build(BuildContext context) {
    final createTeamController = Get.find<CreateTeamController>();

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h,),

        decoration: BoxDecoration(
          color: AppColors.statistic,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: GetBuilder<CreateTeamController>(
          builder: (_) {
            return DropdownButton<int>(
              borderRadius: BorderRadius.circular(20),
              icon: null,
              underline: const SizedBox(),
              value: widget.isClub
                  ? createTeamController.clubsIndex
                  : positionIndex,
              menuMaxHeight: 650.h,
              items: widget.isClub
                  ? List.generate(
                     21,
                      (index) {
                        var club = createTeamController.clubs.isNotEmpty? createTeamController.clubs[index]:null;


                        return DropdownMenuItem(
                          value: index,
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0,right: 3),
                                  child: CachedNetworkImage(
                                    height: 15,
                                    width: 15,
                                    imageUrl:club!=null?  club.logo??
                                        "":"",
                                    placeholder: (context, url) =>
                                        SizedBox(),
                                    errorWidget: (context, url, error) =>SizedBox(),
                                  ),
                                ),
                                Text(
                                  index == 0
                                      ? "Klublar".tr
                                      : club != null
                                          ? club.teamName!.split(" ").first.tr
                                          : "1",
                                  style: const TextStyle(color: Colors.black87),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : List.generate(
                      position.length,
                      (index) {
                        return DropdownMenuItem(
                          value: index,
                          child: Center(
                            child: Padding(
                              padding:  EdgeInsets.only(left: 8.w),
                              child: Text(
                                position[index].tr,
                                style: const TextStyle(color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              selectedItemBuilder: (BuildContext context) {
                return widget.isClub
                    ? List.generate(
                        createTeamController.clubs.length,
                        (index) {
                          var club = createTeamController.clubs[index];
                          return DropdownMenuItem(
                            value: index,
                            child: Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0,right: 3),
                                    child: CachedNetworkImage(
                                      height: 15,
                                      width: 15,
                                      imageUrl: club!=null?  club.logo??
                                          "":"",
                                      placeholder: (context, url) =>
                                          SizedBox(),
                                      errorWidget: (context, url, error) => SizedBox(),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    index == 0
                                        ? "Klublar".tr
                                        : club.teamName != null
                                            ? club.teamName!.split(" ").first.tr
                                            : "1",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : List.generate(position.length, (index) {
                        return Center(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 8.0.w),
                            child: Text(
                              position[index].tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      });
              },
              onChanged: (int? value) {
                if (value != null) {
                  if (widget.isClub) {
                    createTeamController.onClubChange(value); // Update club
                    Logger().i(createTeamController.clubs[createTeamController.clubsIndex].id??1);

                    // Fetch new statistics based on club and current position
                    statisticsController.getStatistics(
                      position: position[positionIndex],
                      clubId: createTeamController.clubs[createTeamController.clubsIndex].id!,
                    );
                  } else {
                    setState(() {
                      positionIndex = value; // Update position
                    });
                    // Fetch new statistics based on position and current club
                    statisticsController.getStatistics(
                      position: position[positionIndex],
                      clubId: createTeamController.clubs[createTeamController.clubsIndex].id!,
                      // clubId: createTeamController.clubsIndex,
                    );
                  }
                }
              },
              isExpanded: false,
            );
          },
        ),
      ),
    );
  }
}
