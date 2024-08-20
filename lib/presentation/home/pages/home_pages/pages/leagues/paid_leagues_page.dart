import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/paid_leagues_page_controller.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class PaidLeaguesPage extends StatefulWidget {
  const PaidLeaguesPage({super.key});

  @override
  State<PaidLeaguesPage> createState() => _PaidLeaguesPageState();
}

class _PaidLeaguesPageState extends State<PaidLeaguesPage> {
  final controller = Get.find<PaidLeaguesPageController>();

  @override
  void initState() {
    super.initState();
    controller.getLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sovrinli ligalar',
          style: CustomStyles.pageTitle,
        ),
      ),
      body: GetBuilder<PaidLeaguesPageController>(
        builder: (_) {
          return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 5,
                        offset: Offset(0, 0))
                  ]),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text("#"),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Ligalar")
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: controller.leagues.length,
                        itemBuilder: (ctx, index) {
                          var league = controller.leagues[index];
                          return GestureDetector(
                            onTap: () {
                              controller.callLeagueDetail(league, context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text("${index + 1}"),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(league.name ?? "")
                                    ],
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ));
        },
      ),
    );
  }
}
