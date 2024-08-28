import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/extra_leagues_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/create_league_page.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/styles.dart';
import '../../../../../widgets/custom_button.dart';
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
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          color: const Color.fromRGBO(50, 199, 50, 0.55),
                          child: Text(
                            controller.league.description ?? "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        if (controller.leagues.isNotEmpty)
                          CachedNetworkImage(
                            width: double.infinity,
                            height: 240,
                            fit: BoxFit.cover,
                            imageUrl: controller.league.image ?? "",
                            placeholder: (context, url) => Container(
                              color: Colors.grey,
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: const Text("No image"),
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.league.name ?? ""} (MW${controller.league.startWeek?.weekNumber ?? ""}-MW${controller.league.endWeek?.weekNumber}) ",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(0, 185, 0, 1),
                                        fontSize: 16),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Teams in",
                                    style: TextStyle(
                                        color: Color.fromRGBO(111, 111, 111, 1),
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${controller.league.teams?.length ?? ""}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 20,
                              ),
                              if (controller.leagues.isNotEmpty)
                                CustomButton(
                                    text: "Ligaga qo'shilish",
                                    onPress: () {
                                      controller.joinLeague(context);
                                    })
                            ],
                          ),
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.callNextPage(CreateLeaguePage(), context);
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          controller.callNextPage(JoinLeaguePage(), context);
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
