import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/statistics/controllers/statistics_page_controller.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/styles.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final controller = Get.find<StatisticsPageController>();

  @override
  void initState() {
    super.initState();
    controller.getPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsPageController>(builder: (_) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(241, 241, 241, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(241, 241, 241, 1),
          title: Text(
            "Oyinchilar statistikasi",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DataTable(
                  columnSpacing: 40,
                  decoration: BoxDecoration(color: Colors.white),
                  dividerThickness: 0.5,
                  columns: const [
                    DataColumn(label: Text('#')),
                    DataColumn(label: Text("O'yinchilar")),
                    DataColumn(label: Text('PTS')),
                    DataColumn(label: Text('')),
                  ],
                  rows: List.generate(
                    controller.players.length,
                    (index) {
                      return DataRow(cells: [
                        DataCell(
                          Text((index + 1).toString()),
                        ),
                        DataCell(Text(controller.players[index].name ?? "")),
                        DataCell(
                            Text("${controller.players[index].score ?? "-"}")),
                        DataCell(
                            const Icon(
                              Icons.info_outline,
                              color: Colors.green,
                            ), onTap: () {
                          controller.callPLayerDetailPage(
                              controller.players[index], context);
                        }),
                      ]);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
