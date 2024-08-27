import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/my_team_controller.dart';
import 'package:football/presentation/intro/controllers/create_team_controller.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:get/get.dart';

class TacticsMenuButton extends StatelessWidget {
  final CreateTeamController controller;

  const TacticsMenuButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CreateTeamController>(builder: (_) {
      return DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: controller.tacticsIndex,
          style: const TextStyle(
            color: Colors.black,
            // Color of the items when displayed in the dropdown
            fontSize: 20,
          ),
          dropdownColor: Colors.white,
          items: List<DropdownMenuItem<int>>.generate(
            4,
            (int index) => DropdownMenuItem<int>(
              value: index,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  tacticsString[index],
                  style: const TextStyle(
                    color: Colors.black,
                    // Color of the items when displayed in the dropdown
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          selectedItemBuilder: (BuildContext context) {
            return [
              for (String item in tacticsString)
                Center(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.white,
                      // Color of the selected item when closed
                      fontSize: 20,
                    ),
                  ),
                )
            ];
          },
          onChanged: (index) {
            controller.onTacticsChange(index);
          },
          icon: const Icon(null, color: Colors.white),
        ),
      );
    });
  }
}


class TacticsMenuButton2 extends StatelessWidget {
  final MyTeamController controller;

  const TacticsMenuButton2({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CreateTeamController>(builder: (_) {
      return DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: controller.tacticsIndex,
          style: const TextStyle(
            color: Colors.black,
            // Color of the items when displayed in the dropdown
            fontSize: 20,
          ),
          dropdownColor: Colors.white,
          items: List<DropdownMenuItem<int>>.generate(
            4,
                (int index) => DropdownMenuItem<int>(
              value: index,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  tacticsString[index],
                  style: const TextStyle(
                    color: Colors.black,
                    // Color of the items when displayed in the dropdown
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          selectedItemBuilder: (BuildContext context) {
            return [
              for (String item in tacticsString)
                Center(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.white,
                      // Color of the selected item when closed
                      fontSize: 20,
                    ),
                  ),
                )
            ];
          },
          onChanged: (index) {
            controller.onTacticsChange(index);
          },
          icon: const Icon(null, color: Colors.white),
        ),
      );
    });
  }
}