import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/leagues_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/extra_leagues.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/paid_league_detail_paid.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/paid_leagues_page.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({super.key});

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  final controller = Get.find<LeaguesPageController>();

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
            "Ligalar",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: GetBuilder<LeaguesPageController>(
          builder: (_) {
            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
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
                                      controller.callLeagueDetail(
                                          league, context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                            text: "Sovrinli ligalar",
                            onPress: () {
                              controller.callNextPage(
                                  const PaidLeaguesPage(), context);
                            }),
                        CustomButton(
                            text: "Qoshimcha ligalar",
                            onPress: () {
                              controller.callNextPage(
                                  const ExtraLeaguesPage(), context);
                            }),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
