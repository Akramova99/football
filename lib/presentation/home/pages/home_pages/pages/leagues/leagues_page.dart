import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/leagues_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/extra_leagues.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/widgets/create_button.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../../default.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/img_roots.dart';
import '../../../../../intro/controllers/create_team_controller.dart';
import '../../controllers/leagues_controller/create_league_controller.dart';
import '../../controllers/leagues_controller/extra_leagues_page_controller.dart';
import 'join_league_page.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({super.key});

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  final controller1 = Get.find<LeaguesPageController>();
  final controller = Get.find<CreateTeamController>();
  final img = Get.find<CreateLeagueController>();
  final nextPage = Get.find<ExtraLeaguesPageController>();

  @override
  void initState() {
    super.initState();
    controller.createTeam();
    controller.getClubs();
    controller.searchPlayers("FORWARD");
    controller1.getLeagues();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Logger().i(height);
    Logger().d(width);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              "Ligalar",
              style: CustomStyles.appBarStyle,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
            bottom: TabBar(
              labelStyle:
                  CustomStyles.dataTitle!.copyWith(color: AppColors.HRed),
              indicatorColor: AppColors.HRed,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  text: 'Ligalar',
                ),
                Tab(text: "Qo'shimcha ligalar"),
              ],
            ),
          ),
          body: GetBuilder<LeaguesPageController>(
            builder: (_) {
              return Stack(
                children: [
                  Center(
                    child: Positioned(
                      top: 0,
                      child: Image.asset(
                        ImgRoots.bg3,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        child: SizedBox(
                          height: 50,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.white60, Colors.white]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        child: SizedBox(
                          height: 50,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                gradient: const LinearGradient(
                                    end: Alignment.topLeft,
                                    begin: Alignment.bottomCenter,
                                    colors: [Colors.white60, Colors.white]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        child: SizedBox(
                          height: 50,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                gradient: const LinearGradient(
                                    end: Alignment.topLeft,
                                    begin: Alignment.bottomCenter,
                                    colors: [Colors.white60, Colors.white]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TabBarView(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            flex: 2,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                          itemCount: controller1.leagues.length,
                                          itemBuilder: (ctx, index) {
                                            var league =
                                                controller1.leagues[index];
                                            return GestureDetector(
                                              onTap: () {
                                                controller1.callLeagueDetail(
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
                                                        ClipOval(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                league.image ??
                                                                    img.img,
                                                            width: 30,
                                                            height: 30,
                                                            fit: BoxFit.cover,
                                                            placeholder:
                                                                (context, url) {
                                                              print(
                                                                  "+++++++++++++++++++++++");
                                                              return Stack(
                                                                children: [
                                                                  Image.asset(
                                                                      "assets/images/home/player_img.png")
                                                                ],
                                                              );
                                                            },
                                                            errorWidget:
                                                                (context, url,
                                                                    error) {
                                                              print(
                                                                  "+++++++++++++++++++++++$error");
                                                              print(
                                                                  "+++++++++++++++++++++++$url");
                                                              return Image
                                                                  .asset(
                                                                "assets/images/home/player_img.png",
                                                                width: 54,
                                                              );
                                                            },
                                                          ),
                                                        ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CreateButton(
                                      text: "Liga yaratish",
                                      onPress: () {
                                        //   nextPage.callNextPage(CreateLeaguePage(), context);
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          //   isScrollControlled: true, // To'liq ekran qilish uchun
                                          builder: (context) =>
                                              const CreateLeaguePage(),
                                        );
                                      },
                                      color: AppColors.baseColor),
                                  CreateButton(
                                      text: "Ligaga qo'shilish",
                                      onPress: () {
                                        showModalBottomSheet(
                                          context: context,

                                          // isScrollControlled: true, // To'liq ekran qilish uchun
                                          builder: (context) =>
                                              const JoinLeaguePage(),
                                        );
                                      },
                                      color: AppColors.baseColor),
                                  // Import this to use Clipboard

                                  img.isCreate
                                      ? Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: AppColors.baseColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: MaterialButton(
                                            onPressed: () {
                                              // Function to copy the text to clipboard
                                              Clipboard.setData(
                                                  ClipboardData(
                                                      text: controller1
                                                          .leagues
                                                          .last
                                                          .id!));

                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  controller1.leagues.last.id!,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                const Icon(
                                                  Icons.content_copy,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox()

                                  // CustomButton(
                                  //
                                  //     text: "Qoshimcha ligalar",
                                  //     onPress: () {

                                  //     }),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      ExtraLeaguesPage()
                    ],
                  )
                ],
              );
            },
          )),
    );
  }
}
