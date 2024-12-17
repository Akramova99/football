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
import '../../../../../../models/league_model.dart';
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
    // Set TabController in the controller

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

    return GetBuilder<CreateLeagueController>(
      builder: (_) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                "Ligalar".tr,
                style: CustomStyles.appBarStyle,
              ),
              leading: IconButton(
                onPressed: () {
               //   Navigator.pop(context);
                  Navigator.of(context).popUntil((route) => route.isFirst);

                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              bottom: TabBar(
                labelStyle: CustomStyles.dataTitle!.copyWith(color: AppColors.HRed),
                indicatorColor: AppColors.HRed,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs:  [
                  Tab(text: 'Ligalar'.tr),
                  Tab(text: "Qo'shimcha ligalar".tr),
                ],
              ),
            ),
            body: GetBuilder<LeaguesPageController>(
              builder: (controller1) {
                return Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        ImgRoots.bg3,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        _buildBlurredHeader(),
                        _buildBlurredHeader(),
                        _buildBlurredHeader(),
                      ],
                    ),
                    TabBarView(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: _buildLeaguesList(controller1),
                            ),
                            Expanded(
                              flex: 1,
                              child: _buildCreateJoinButtons(),
                            ),
                          ],
                        ),
                        const ExtraLeaguesPage(),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBlurredHeader() {
    return ClipRRect(
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
                colors: [Colors.white60, Colors.white],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaguesList(LeaguesPageController controller) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.tableColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      width: double.infinity,
      child: Column(
        children: [
          _buildLeaguesHeader(),
          GetBuilder<CreateLeagueController>(
            builder: (_) {
              if (controller.leagues == null) {
                return Center(child: CircularProgressIndicator()); // Loading indicator
              }

              return Expanded(
                child: controller.leagues.isEmpty
                    ? Center(child: Text('Hech qanday liga mavjud emas'.tr,style: CustomStyles.dataTitle,))
                    : ListView.builder(
                  itemCount: controller.leagues.length,
                  itemBuilder: (ctx, index) {
                    var league = controller.leagues[index];
                    return _buildLeagueItem(league, index);
                  },
                ),
              );
            },
          ),
        ],
      )
    );
  }

  Widget _buildLeaguesHeader() {
    return Container(
      padding: EdgeInsets.all(10),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text("#",style: CustomStyles.dataTitle,),
              const SizedBox(width: 20),
              Text("Ligalar".tr,style: CustomStyles.dataTitle,),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildLeagueItem(LeagueModel  league, int index) {
    return GestureDetector(
      onLongPress: () {
        controller1.deleteLeague(); // Correct deletion handling needed here

      },
      onTap: () {
        controller1.callLeagueDetail(league, context,league.name ?? "Unnamed League"); // Navigate to league details
      },
      child: Container(

        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("${index + 1}",style: CustomStyles.dataTitle,),
                const SizedBox(width: 10),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: league.image ?? img.img,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/team/placeholder.png",
                      width: 54,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/team/placeholder.png",
                      width: 54,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(league.name ?? "Unnamed League",style: CustomStyles.dataTitle,),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateJoinButtons() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CreateButton(
            text: "Liga yaratish".tr,
            onPress: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const CreateLeaguePage(),
              );
            },
            color: AppColors.baseColor,
          ),
          CreateButton(
            text: "Ligaga qo'shilish".tr,
            onPress: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const JoinLeaguePage() ,
              ).whenComplete(() {
                // Additional logic can go here if necessary when the bottom sheet is dismissed
                Navigator.pop(context);
              });
            },
            color: AppColors.baseColor,
          ),
          img.isCreate
              ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.baseColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: MaterialButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: controller1.leagues.last.id!));
              },
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller1.leagues.isNotEmpty) // Check if leagues list is not empty
                    Text(
                      controller1.leagues.last.id!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else
                    Text(
                      'No ID available', // Display an alternative message if list is empty
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  const SizedBox(width: 20),
                  const Icon(Icons.content_copy, color: Colors.white, size: 24),
                ],
              )

            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }




}
