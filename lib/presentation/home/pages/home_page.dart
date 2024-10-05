import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/home_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/navigate_league_page.dart';
import 'package:football/presentation/home/widgets/tab_element.dart';
import 'package:football/presentation/widgets/custom_home_menu_item.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../controllers/deadline_controller.dart';
import 'home_pages/pages/leagues/leagues_page.dart';

class HomePage extends StatefulWidget {
  final PageController pageController;

  const HomePage({super.key, required this.pageController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<HomePageController>();
  final deadController = Get.find<DeadlineController>();
  late StreamSubscription _streamSubscription;
  bool isDeviceConnect = false;
  bool isAlert = false;



  internetConnection() => _streamSubscription =
      Connectivity().onConnectivityChanged.listen((result) async {
        isDeviceConnect = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnect && isAlert == false) {
          showDialogBox();
          setState(() {
            isAlert = true;
          });
        }
      });

  showDialogBox() => showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("You appear to be offline"),
          content: Text(
              "You can't use this app until ypu're connected to the internet"),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() {
                    isAlert = false;
                  });
                  isDeviceConnect =
                  await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnect && isAlert == false) {
                    showDialogBox();
                    setState(() {
                      isAlert = true;
                    });
                  }
                },
                child: Text("OK"))
          ],
        );
      });

  @override
  void initState() {
    super.initState();
    internetConnection();
    controller.getUserData();
    controller.getNotification();
    Get.lazyPut<DeadlineController>(() => DeadlineController());

    deadController.getDeadlineData();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (_) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 3),
        appBar: AppBar(
          //  shadowColor: Colors.grey,
          elevation: 5,
          //toolbarHeight: 100,
          automaticallyImplyLeading: false,
          primary: true,
          backgroundColor: const Color.fromRGBO(250, 250, 250, 3),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Salom".tr,
                // "${"Salom".tr},",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 18),
              ),
              Text(
                controller.name ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontSize: 18),
              ),
            ],
          ),
          actions: [
            Container(
              width: 32,
              height: 32,
              margin: EdgeInsets.only(right: 20),
              padding: EdgeInsets.only(top: 4, right: 4),
              decoration: BoxDecoration(
                  color: AppColors.HRed,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                    controller.notifications.isNotEmpty
                        ? Container(
                            alignment: Alignment.center,
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                shape: BoxShape.circle,
                                color: Colors.purple),
                            child: Text(
                              "${controller.notifications.length}",
                              style: const TextStyle(
                                  fontSize: 8, color: Colors.white),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                onTap: () {
                  controller.callNotificationPage(context);
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Container(
              //  height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),

                  GetBuilder<DeadlineController>(builder: (_) {
                    String formattedDateTime =
                        deadController.deadline.replaceAll('T', ' ');
                    return Text(
                      "${"Liga vaqti".tr}: $formattedDateTime",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 16),
                    );
                  }),

                  Text(
                    "Sovrinli ligalar".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TabElement(
                          text: "PREMIER LEAGUE".tr,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NavigateLeaguePage()),
                            );
                          },
                          imgPath: "central_img",
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        TabElement(
                            text: "UEFA Yevropa\nLigasi".tr,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LeaguesPage()),
                              );
                            },
                            imgPath: "central_p2"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Qoshimcha ma\'lumotlar".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 16),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomHomeMenuItem(
                          data: homeMenuItems[0],
                          data2: homeMenuTitle[0],
                        ),
                        CustomHomeMenuItem(
                          data: homeMenuItems[1],
                          data2: homeMenuTitle[1],
                        ),
                        CustomHomeMenuItem(
                          data: homeMenuItems[2],
                          data2: homeMenuTitle[2],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CustomHomeMenuItem(
                        data: homeMenuItems[3],
                        data2: homeMenuTitle[3],
                      ),
                      CustomHomeMenuItem(
                        data: homeMenuItems[4],
                        data2: homeMenuTitle[4],
                      ),
                      CustomHomeMenuItem(
                        data: homeMenuItems[5],
                        data2: homeMenuTitle[5],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Bizning ligalar".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 16),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  InkWell(
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LeaguesPage()),
                        );
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          // The actual image
                          Image.asset("assets/images/home/league1.png"),

                          // Glassmorphism overlay
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 2.0),
                            // Adjust blur intensity
                            child: Container(
                              color:
                                  Colors.white.withOpacity(0.4), // 40% opacity
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 22,
                                  decoration: const BoxDecoration(
                                      color: AppColors.HRed,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: Text(
                                      "UzbCup League".tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 90,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "As it happened: Spain win final".tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      "As it happened: Spain win final".tr,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 11,
                                          fontFamily: "Poppins"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LeaguesPage()),
                        );
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          // The actual image
                          Image.asset("assets/images/home/league2.png"),

                          // Glassmorphism overlay
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 2.0),
                            // Adjust blur intensity
                            child: Container(
                              color:
                                  Colors.white.withOpacity(0.4), // 40% opacity
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 22,
                                  decoration: const BoxDecoration(
                                      color: AppColors.HRed,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Uzb Sila League".tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Quarter - Finals ties set".tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                     homeTex.tr,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 11,
                                          fontFamily: "Poppins"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Blur effektini qo'shish
                  //SizedBox(height: 200,),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
