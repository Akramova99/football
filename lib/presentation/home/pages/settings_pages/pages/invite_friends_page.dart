import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/invite_friends_controller.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/img_roots.dart';

class InviteFriendsPage extends StatefulWidget {
  const InviteFriendsPage({super.key});

  @override
  State<InviteFriendsPage> createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  final controller = Get.find<InviteFriendsController>();

  @override
  void initState() {

    super.initState();
    controller.getData();
    controller.getMyLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImgRoots.bg1,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        Spacer(),
                        Text(
                          "Do'stlarni taklif qilish",
                          style: CustomStyles.appBarStyle,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  GetBuilder<InviteFriendsController>(
                    builder: (_) {
                      return Container(
                        padding: EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //share a link
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                         //       height: 188,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Baham Ko’rish",
                                      style: TextStyle(
                                          fontSize: 24, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Do’stlaringiz bilan baham ko’ring va ulashing",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(51, 51, 51, 1)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(height: 46,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color:  AppColors.violit,
                                              width: 1)),
                                      child: MaterialButton(
                                        onPressed: () {
                                          controller.share();
                                        },
                                        child: const Row(
                                          children: [
                                            Text(
                                              "Havolani almashish",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                                color:  AppColors.violit,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(Icons.share,
                                                color: AppColors.violit)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              //password of league
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                            //    height: 188,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Liga kodi",
                                      style: TextStyle(
                                          fontSize: 24, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Ushbu havolani do'stlaringizga yuboring va ularni Ligaga taklif qiling",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(51, 51, 51, 1)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 46,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color:  AppColors.violit,
                                              width: 1)),
                                      child: MaterialButton(
                                        onPressed: () {
                                          controller.copyText(controller.myLeague.id!);
                                        },
                                        child: Row(
                                          children: [
                                            Text(controller.leaguePassword ?? "",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color:  AppColors.violit,
                                                )),
                                            Spacer(),
                                            Image.asset(
                                              "assets/images/settings/copy_img.png",
                                           color:    AppColors.violit,
                                              height: 22,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              //link to league
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                              //  height: 188,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Ligaga havola",
                                      style: TextStyle(
                                          fontSize: 24, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Ushbu havolani do'stlaringizga yuboring va ularni Ligaga taklif qiling",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                         ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 46,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.violit,
                                              width: 1)),
                                      child: MaterialButton(
                                        onPressed: () {
                                          controller.copyText("");
                                        },
                                        child: Row(
                                          children: [
                                            Text(controller.leagueLink ?? "",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.violit,
                                                )),
                                            const Spacer(),
                                            Image.asset(
                                              "assets/images/settings/copy_img.png",
                                              color:  AppColors.violit,
                                              height: 22,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}
