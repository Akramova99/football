import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/web.dart';

import '../../../models/chart_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../controllers/balance_page_controller.dart';

class BarChartSample1 extends StatefulWidget {
  BarChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Duration animDuration = const Duration(milliseconds: 250);
  final controller = Get.find<BalancePageController>();

  int touchedIndex = -1;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    controller.getChartData(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: GetBuilder<BalancePageController>(
              // Wrapping in GetBuilder
              builder: (controller) {
                if (controller.chart.isEmpty) {
                  // Show a loading indicator or a message while waiting for data
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      height: 309,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              color: Colors.white30,
                              child: BarChart(
                                isPlaying
                                    ? randomData()
                                    : mainBarData(controller),
                                swapAnimationDuration: animDuration,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  BarChartData mainBarData(BalancePageController controller) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String month;
            switch (group.x) {
              case 0:
                month = 'Jan';
                break;
              case 1:
                month = 'Feb';
                break;
              case 2:
                month = 'March';
                break;
              case 3:
                month = 'Apr';
                break;
              case 4:
                month = 'May';
                break;
              case 5:
                month = 'Jun';
                break;
              case 6:
                month = 'Jul';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$month\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: AppColors.chartC2,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => getLeftTitles(
              value,
              meta,
            ),
            reservedSize: 40,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.chartC2,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      fontFamily: "Poppins",
    );
    List<String> months = ["Jan", "Feb", "March", "Apr", "May", "Jun", "July"];

    // Hozirgi oyni olish
    String currentMonth = DateFormat('MMM').format(DateTime.now());

    // Agar hozirgi oy listda mavjud bo'lsa, faqat o'sha oyni ko'rsatamiz
    if (!months.contains(currentMonth)) {
      // newMonths.add(currentMonth);
      months = ["Jun", "July", "Aug", "Sep", "Oct", "Nov", "Dec"];
    }
    //List<String> months = ["Jan", "Feb", "March", "Apr", "May", "Jun", "July"];

    String text = '';
    if (value.toInt() >= 0 && value.toInt() < months.length) {
      text = months[value.toInt()];
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(text, style: style),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.chartC2,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    // Show values only at intervals of 5 for readability.
    if (value % 5 == 0) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4,
        child: Text((value * 1).toInt().toString(), style: style),
      );
    }
    return Container();
  }



  List<BarChartGroupData> showingGroups() {
    // Define months in order for reference (showing only first 7 months, adjust accordingly)
    List<String> months = [
      "JANUARY",
      "FEBRUARY",
      "MARCH",
      "APRIL",
      "MAY",
      "JUNE",
      "JULY"
    ];
    String currentMonth = DateFormat('MMM').format(DateTime.now());

    if (!months.contains(currentMonth)) {
      // newMonths.add(currentMonth);
      months = [
        "JUNE",
        "JULY",
        "AUGUST",
        "SEPTEMBER",
        "OCTOBER",
        "NOVEMBER",
        "DECEMBER"
      ];
    }

    // Get the chart data for the current year (assuming the first element is used)
    if (controller.chart.isEmpty) return [];
    Logger().i(controller.chart.isEmpty);
    YearlyPayment currentYear = controller.chart.first;

    // Prepare the total amounts for each month with a default value of 0
    Map<String, double> monthTotals = {
      for (var month in months) month: 0.0,
    };

    // Populate the map with the actual values from the API
    for (var payment in currentYear.monthlyPayments) {
      if (monthTotals.containsKey(payment.month)) {
        monthTotals[payment.month] = payment.totalAmount;
        // monthTotals["OCTOBER"] = 672;
        Logger().d(payment.month);
        Logger().d(monthTotals);
      }
    }

    // Generate the BarChartGroupData using switch-case for each of the 7 months
    return List.generate(7, (i) {
      double totalAmount = monthTotals[months[i]] ?? 0.0;
      Logger().w(totalAmount);
      switch (i) {
        case 0:
          return makeGroupData(0, totalAmount, isTouched: i == touchedIndex);
        case 1:
          return makeGroupData(1, totalAmount, isTouched: i == touchedIndex);
        case 2:
          return makeGroupData(2, totalAmount, isTouched: i == touchedIndex);
        case 3:
          return makeGroupData(3, totalAmount, isTouched: i == touchedIndex);
        case 4:
          return makeGroupData(4, totalAmount, isTouched: i == touchedIndex);
        case 5:
          return makeGroupData(5, totalAmount, isTouched: i == touchedIndex);
        case 6:
          return makeGroupData(6, totalAmount, isTouched: i == touchedIndex);
        default:
          return throw Error();
      }
    });
  }

  List<BarChartGroupData> showingGroups1() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartGroupData makeGroupData(int x, double y,
      {bool isTouched = false, Color? barColor, double width = 22}) {
    barColor ??= AppColors.HRed;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          // Bar height based on data
          color: isTouched ? AppColors.contentColorGreen : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: AppColors.contentColorGreen.darken(0.80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20, // Fixed maximum height for background bars
            color: AppColors.contentColorWhite.darken().withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  BarChartData randomData() {
    return BarChartData(
      maxY: 20,
      // Ensure random data also respects the fixed max height
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 1);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 1);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 1);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 1);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 1);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 1);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 1);
          default:
            return throw Error();
        }
      }),
    );
  }
}
