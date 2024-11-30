import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/presentation/home/pages/home_pages/pages/points_pages/player_chart_controller.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class DropdownButOfChart extends StatefulWidget {
  final String text;
  final String playerId;

  const DropdownButOfChart(
      {super.key, required this.text, required this.playerId});

  @override
  State<DropdownButOfChart> createState() => _DropdownButState();
}

class _DropdownButState extends State<DropdownButOfChart> {
  int positionIndex = 0; // For position dropdown
  // For position dropdown

  final chartController = Get.find<PlayerChartController>();
  List<String> typeOfChart(int index) => List.generate(
    chartController.matchScore.isNotEmpty
        ? chartController.matchScore.length
        : 1,
        (index) => "1-${index+1}  tur",
  );
  @override
  void initState() {
    super.initState();
    chartController.getPlayerByTypeChartData(
        widget.playerId, 1, 3);
    // Fetch default statistics on init
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5.h,
        ),
        decoration: BoxDecoration(
            color: AppColors.statistic,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white)),
        child: GetBuilder<PlayerChartController>(
          builder: (_) {
            return DropdownButton<int>(
              borderRadius: BorderRadius.circular(20),
              icon: null,
              underline: const SizedBox(),
              value: positionIndex,
              menuMaxHeight: 200.h,
              items: List.generate(
                chartController.matchScore.isNotEmpty
                    ? chartController.matchScore.length
                    : 1,
                (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          typeOfChart(index)[index],
                          style: CustomStyles.dataTitle!
                              .copyWith(color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
              selectedItemBuilder: (BuildContext context) {
                return List.generate(chartController.matchScore.isNotEmpty
                    ? chartController.matchScore.length
                    : 1, (index) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: Text(
                        typeOfChart(index)[index],
                        style: CustomStyles.dataTitle!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  );
                });
              },
              onChanged: (int? value) {
                if (value != null) {
                  setState(() {
                    positionIndex = value; // Update position
                  });

                  chartController.getPlayerByTypeChartData(
                      widget.playerId, 1, value + 1);
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
