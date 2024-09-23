import 'package:flutter/material.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../intro/controllers/create_team_controller.dart';
import '../pages/statistics/controllers/statistics_page_controller.dart';

class DropdownBut extends StatefulWidget {
  //i need PlayerDetailModel

  final String text;

  const DropdownBut({super.key, required this.text});

  @override
  State<DropdownBut> createState() => _DropdownButState();
}

class _DropdownButState extends State<DropdownBut> {
  @override
  Widget build(BuildContext context) {
  //  String myValue = "Forward";
    final controller = Get.find<CreateTeamController>();
    String? myValue = null;
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        width: 144,

        decoration: BoxDecoration(
          color: AppColors.statistic,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          children: [
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
            DropdownButton<int>(
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
                          : "1",
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
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItems(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 20),
      ));
}
