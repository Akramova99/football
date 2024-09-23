import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/home_page_controller.dart';
import 'package:football/presentation/home/widgets/tab_element.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/presentation/widgets/custom_home_menu_item.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final PageController pageController;

  const HomePage({super.key, required this.pageController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<HomePageController>();

  @override
  void initState() {
    super.initState();
    controller.getUserData();
    controller.getNotification();
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
          primary: true,
          backgroundColor: const Color.fromRGBO(250, 250, 250, 3),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,",
                style: const TextStyle(
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                //127 131
                // SizedBox(
                //   width: double.infinity,
                //   child: TimeDisplay(
                //     controller: controller,
                //   ),
                // ),
                const Text(
                  "Sovrinli ligalar",
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
                          text: "PREMIER LEAGUE",
                          onPress: () {},
                          imgPath: "central_img"),
                      const SizedBox(
                        width: 15,
                      ),
                      TabElement(
                          text: "UEFA Europa\nLeague",
                          onPress: () {},
                          imgPath: "central_p2"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Qoshimcha ma’lumotlar",
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
                      ),
                      CustomHomeMenuItem(
                        data: homeMenuItems[1],
                      ),
                      CustomHomeMenuItem(
                        data: homeMenuItems[2],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    CustomHomeMenuItem(
                      data: homeMenuItems[3],
                    ),
                    CustomHomeMenuItem(
                      data: homeMenuItems[4],
                    ),
                    CustomHomeMenuItem(
                      data: homeMenuItems[5],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Bizning Ligalar",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 16),
                ),

                const SizedBox(
                  height: 20,
                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      // The actual image
                      Image.asset("assets/images/home/league1.png"),
                  
                      // Glassmorphism overlay
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 2.0), // Adjust blur intensity
                        child: Container(
                          color: Colors.white.withOpacity(0.4), // 40% opacity
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(
                              height: 22,
                              decoration:  const BoxDecoration(
                                  color: AppColors.HRed,
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: MaterialButton(
                                onPressed: () {

                                },
                                child: Text(
                                  "UzbCup League",
                                  style: const TextStyle(color: Colors.white, fontSize: 11,fontFamily: "Poppins"),
                                ),
                              ),
                            ),
                            SizedBox(height: 90,),

                            Column(
                              children: [
                                Text(
                                  "As it happened: Spain win final",
                                  style: const TextStyle(color: Colors.white, fontSize: 11,fontFamily: "Poppins",fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "As it happened: Spain win final",
                                  style:  TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11,fontFamily: "Poppins"),
                                ),
                              ],
                            )

                          ],
                        ),
                      )

                    ],
                  ),
                ),
                  // Blur effektini qo'shish


              ],
            ),
          ),
        ),
      );
    });
  }
}
