import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  leading: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios,size: 23,)),
                  title: Text(
                    'Taqvim'.tr,
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
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 400.h, // Muayyan balandlik belgilash
                          child: TabBarView(
                            children: controller.matches
                                .map((match) => MatchListView(
                              matches: match,
                            ))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
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
                            isSeeAll: true,
                            teams: controller.teams,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  "Taqvim".tr,
                  style: CustomStyles.pageTitle,
                ),
              ),
              body:  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      "${"Iltimos kuting".tr}...",
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
              ),
            );
    });
  }
}
