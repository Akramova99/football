import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/extra_leagues_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/create_league_page.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/styles.dart';
import 'join_league_page.dart';

class ExtraLeaguesPage extends StatefulWidget {
  const ExtraLeaguesPage({super.key});

  @override
  State<ExtraLeaguesPage> createState() => _ExtraLeaguesPageState();
}

class _ExtraLeaguesPageState extends State<ExtraLeaguesPage> {
  final controller = Get.find<ExtraLeaguesPageController>();

  @override
  void initState() {
    super.initState();
    controller.getLeagues();
    controller.getMyLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Qo'shimch ligalar",
          style: CustomStyles.pageTitle,
        ),
      ),
      body: GetBuilder<ExtraLeaguesPageController>(
        builder: (_) {
          return Container(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
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
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.callNextPage(
                                  CreateLeaguePage(), context);
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.grey, blurRadius: 8)
                                  ]),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Liga yaratish",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 24,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.callNextPage(
                                  JoinLeaguePage(), context);
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.grey, blurRadius: 8)
                                  ]),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ligalarga qo'shilish",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 24,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              controller.copyLink();
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(5, 255, 0, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.myLeague.id ?? "",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.copy_sharp,
                                    size: 24,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
