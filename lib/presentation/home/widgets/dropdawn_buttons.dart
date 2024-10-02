import 'package:flutter/material.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:get/get.dart';

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
  StatisticsPageController statisticsController = Get.find<StatisticsPageController>();

  @override
  void initState() {
    super.initState();
    statisticsController.fetchDefaultStatistics(); // Fetch default statistics on init
  }

  @override
  Widget build(BuildContext context) {
    final createTeamController = Get.find<CreateTeamController>();

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        width: 140,
        decoration: BoxDecoration(
          color: AppColors.statistic,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: GetBuilder<CreateTeamController>(
          builder: (_) {
            return DropdownButton<int>(
              underline: const SizedBox(),
              value: widget.isClub ? createTeamController.clubsIndex : positionIndex,
              menuMaxHeight: 200,
              items: widget.isClub
                  ? List.generate(
                createTeamController.clubs.length,
                    (index) {
                  var club = createTeamController.clubs[index];

                  return DropdownMenuItem(
                    value: index,
                    child: Text(
                      index == 0
                          ? "Clubs"
                          : club.teamName != null
                          ? club.teamName!.split(" ").first
                          : "1",
                      style: const TextStyle(color: Colors.black87),
                    ),
                  );
                },
              )
                  : List.generate(
                position.length,
                    (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text(
                      position[index],
                      style: const TextStyle(color: Colors.black87),
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
                      child: Text(
                        index == 0
                            ? "Clubs"
                            : club.teamName != null
                            ? club.teamName!.split(" ").first
                            : "1",
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                )
                    : List.generate(position.length, (index) {
                  return Center(
                    child: Text(
                      position[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                });
              },
              onChanged: (int? value) {
                if (value != null) {
                  if (widget.isClub) {
                    createTeamController.onClubChange(value); // Update club
                    // Fetch new statistics based on club and current position
                    statisticsController.getStatistics(
                      position: position[positionIndex],
                      clubId: value,
                    );
                  } else {
                    setState(() {
                      positionIndex = value; // Update position
                    });
                    // Fetch new statistics based on position and current club
                    statisticsController.getStatistics(
                      position: position[positionIndex],
                      clubId: createTeamController.clubsIndex,
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



// DropdownButtonHideUnderline(
//   child: DropdownButton(
//     icon: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Icon(Icons.arrow_drop_up_outlined, color: Colors.white, size: 15),
//         Icon(Icons.arrow_drop_down_outlined, color: Colors.white, size: 15),
//       ],
//     ),
//     value: controller.clubsIndex,
//     hint: Text(myValue??widget.text, style: TextStyle(color: Colors.white)),
//     items: List.generate(
//       controller.clubs.length,
//           (index) {
//         var club = controller.clubs[index];
//         return DropdownMenuItem(
//           value: index,
//           child: Text(
//             index == 0
//                 ? "Clubs"
//                 : club.teamName != null
//                 ? club.teamName!.split(" ").first
//                 : "1",
//             style:
//             const TextStyle(color: Colors.black),
//           ),
//         );
//       },
//     ),
//     onChanged: (int? value) => setState(() {
//       controller.onClubChange(value);
//       Logger().i(myValue);
//     }),
//   ),
// ),
// DropdownButtonHideUnderline(
//   child: DropdownButton(
//     icon: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Icon(Icons.arrow_drop_up_outlined, color: Colors.white, size: 15),
//         Icon(Icons.arrow_drop_down_outlined, color: Colors.white, size: 15),
//       ],
//     ),
//     value: myValue,
//     hint: Text(myValue??widget.text, style: TextStyle(color: Colors.white)),
//     items: statisticPosition.map(buildMenuItems).toList(),
//     onChanged: (value) => setState(() {
//       myValue = value;
//       Logger().i(myValue);
//     }),
//   ),
// ),
