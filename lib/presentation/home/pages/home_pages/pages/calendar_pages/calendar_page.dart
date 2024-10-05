import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/calendar_page_controller.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/styles.dart';
import '../../../../../widgets/mateches_widget.dart';
import '../../../../../widgets/ranking_table_widget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final controller = Get.find<CalendarPageController>();

  @override
  void initState() {
    super.initState();
    controller.getData();
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarPageController>(builder: (_) {
      return
        controller.isDataReady
          ? DefaultTabController(
              length: controller.weeks.length,
              child: Scaffold(
                backgroundColor: Color.fromRGBO(241, 241, 241, 1),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Taqvim',
                    style: CustomStyles.pageTitle,
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: List.generate(
                      controller.weeks.length,
                      (index) => Tab(
                        text: controller.weeks.isNotEmpty
                            ? "${controller.weeks[index].weekNumber} - tur o'yinlar"
                            : "",
                      ),
                    ),
                  ),
                ),
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: TabBarView(
                            children: controller.matches
                                .map((match) => MatchListView(
                                      matches: match,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.callAllRating(context);
                                  },
                                  child: Text(
                                    "Umumiy Reyting",
                                    style: CustomStyles.pageTitle,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: SoccerRankingTable(
                                  teams: controller.teams,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  "Taqvim",
                  style: CustomStyles.pageTitle,
                ),
              ),
              body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      "Please wait...",
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
              ),
            );
    });
  }
}
