import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../models/week_chart_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../pages/home_pages/pages/points_pages/drop_down_of_chart.dart';
import '../pages/home_pages/pages/points_pages/player_chart_controller.dart';

class LineChartSample2 extends StatefulWidget {
  String? playerId;
   LineChartSample2({super.key,this.playerId});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {

  late final PlayerChartController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PlayerChartController()); // Register controller here

    //controller.getPlayerChartData(widget.playerId??"2");

  }
  List<Color> gradientColors = [
  //  AppColors.contentColorCyan,
    AppColors.HRed,
    AppColors.red,
   // AppColors.contentColorBlue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<PlayerChartController>(builder: (_) {
      return ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                // width: 60,
                // height: 34,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  child: Text(
                    'avg',
                    style: TextStyle(
                      fontSize: 12,
                      color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                    ),
                  ),
                ),
              ),
               DropdownButOfChart(
                text: "1-3 tur",
                playerId: widget.playerId??"0",

              ),
            ],
          ),
          SizedBox(
            height: 300, // Set the desired height
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,

              ),
              child: LineChart(
                showAvg ? avgData(controller) : mainData(controller),
              ),
            ),
          ),

        ],
      );
    })
      ;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 10,
    );
    Widget text;
    Logger().d(widget.playerId);
    // Hozirgi oyni aniqlash
    int currentMonth = DateTime.now().month;

    // Agar hozirgi oy oktabrdan oldin bo'lsa birinchi switch ishlaydi
    if (currentMonth < 10) {
      switch (value.toInt()) {
        case 2:
          text = const Text('MAR', style: style);
          break;
        case 5:
          text = const Text('JUN', style: style);
          break;
        case 8:
          text = const Text('SEP', style: style);
          break;
        case 7:
          text = const Text('AUG', style: style);
          break;
        case 6:
          text = const Text('JUL', style: style);
          break;
        case 9:
          text = const Text('OCT', style: style);
          break;
        case 3:
          text = const Text('APR', style: style);
          break;
        case 4:
          text = const Text('MAY', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }
    } else {
      // Aks holda (oktabrdan keyingi oylarda) ikkinchi switch ishlaydi
      switch (value.toInt()) {
        case 2:
          text = const Text('OCT', style: style);
          break;
        case 3:
          text = const Text('NOV', style: style);
          break;
        case 4:
          text = const Text('DEC', style: style);
          break;
        case 5:
          text = const Text('JAN', style: style);
          break;
        case 6:
          text = const Text('FEB', style: style);
          break;
        case 7:
          text = const Text('MAR', style: style);
          break;
        case 8:
          text = const Text('APR', style: style);
          break;
        case 9:
          text = const Text('MAY', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }


  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10';
        break;
      case 3:
        text = '30';
        break;
      case 5:
        text = '50';
        break;
      case 2:
        text = '20';
        break;
      case 4:
        text = '40';
        break;
      case 6:
        text = '60';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(PlayerChartController controller) {
    List<MatchScore> list = controller.matchScore;

    // FlSpot obyektlarini yaratish
    List<FlSpot> spots = List.generate(10, (index) {
      // Agar list bo'sh bo'lsa, `y` qiymati 0 bo'ladi, bo'sh bo'lmasa list dan olinadi
      double yValue = (list.isNotEmpty && index < list.length)
          ? list[index].totalScore.toDouble()
          : 0.0;
      return index>1? FlSpot(index.toDouble(), yValue):FlSpot(0,3);
    });

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
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
            reservedSize: 28,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 28,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 10, // Ko'rsatilgan maksimal x qiymati
      minY: 0,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }


  LineChartData avgData(PlayerChartController controller) {
    List<MatchScore> list = controller.matchScore;

    // FlSpot obyektlarini yaratish
    List<FlSpot> spots = List.generate(10, (index) {
      // Agar list bo'sh bo'lsa, `y` qiymati 3.44 bo'ladi, bo'sh bo'lmasa list dan olinadi
      double yValue = (list.isNotEmpty && index < list.length)
          ? list[index].totalScore.toDouble()
          : 3.44;
      return FlSpot(index.toDouble(), yValue);
    });

    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11, // Ko'rsatilgan maksimal x qiymati
      minY: 0,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

}











//
// class LineChartSample2 extends StatefulWidget {
//   const LineChartSample2({super.key});
//
//   @override
//   State<LineChartSample2> createState() => _LineChartSample2State();
// }
//
// class _LineChartSample2State extends State<LineChartSample2> {
//   List<Color> gradientColors = [
//     AppColors.HRed,
//     AppColors.red,
//   ];
//
//   bool showAvg = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         // Use SizedBox to specify a height of 350 for the chart
//         SizedBox(
//           height: 350, // Set the desired height
//           child: Padding(
//             padding: const EdgeInsets.only(
//               right: 18,
//               left: 12,
//               top: 24,
//               bottom: 12,
//             ),
//             child: LineChart(
//               showAvg ? avgData() : mainData(),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 60,
//           height: 34,
//           child: TextButton(
//             onPressed: () {
//               setState(() {
//                 showAvg = !showAvg;
//               });
//             },
//             child: Text(
//               'avg',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
// // Rest of your existing code...
// }
