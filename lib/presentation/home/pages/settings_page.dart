import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/setting_page_controller.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/profile_page_controller.dart';
import 'package:football/presentation/home/pages/settings_pages/widgets/settings_items.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/img_roots.dart';
import '../../widgets/language_dialog.dart';
import 'home_pages/controllers/leagues_controller/create_league_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final controller = Get.find<SettingPageController>();
  final profile = Get.find<ProfilePageController>();
  final chooseImg = Get.find<CreateLeagueController>();


  @override
  void initState() {
    super.initState();
    profile.getData();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(builder: (_) {
      return  Scaffold(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // IconButton(onPressed: (){
                          //   Navigator.pop(context);
                          // }, icon: Icon(Icons.arrow_back_ios)),
                          Text(
                            "Sozlamalar",
                            style: CustomStyles.appBarStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 90,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      decoration: BoxDecoration(
                          color: AppColors.baseColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              width: 54,
                              height: 54,
                              fit: BoxFit.cover,
                              // Bu rasmning to'liq joylashishiga yordam beradi
                              placeholder: (context, url) {
                                print("+++++++++++++++++++++++");
                                return Stack(
                                  children: [
                                    Image.asset(
                                      "assets/images/home/player_img.png",
                                      width: 54,
                                      height: 54,
                                    ),
                                  ],
                                );
                              },
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/home/player_img.png",
                                width: 54,
                                height: 54,
                              ),
                              imageUrl:
                              profile.user.image??'http://46.101.131.127:8080/api/v1/files/league_eeb750ce-6ce1-4622-a713-5bc6e826bce0.png',
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                profile.name?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                profile.user.email??"",
                                style: CustomStyles.dataTitle,
                              ),
                            ],
                          ),
                          Image.asset(
                            ImgRoots.edit,
                            height: 24,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: const Color.fromRGBO(246, 246, 246, 1),
                            width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                              (index) {
                            return index == 0
                                ? SettingsItem(
                              data: settingMenuItems[index],
                              changeLanguage: () {
                                showLanguageDialog(context);
                              },
                            )
                                : SettingsItem(
                              data: settingMenuItems[index],
                              changeLanguage: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return settingMenuItems[index]['rout'];
                                    }));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 5.0),
                        // Blur effektini qo'shish
                        child: Container(
                          height: 104,
                          width: 340,
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Ko'proq",
                                  style: CustomStyles.dataTitle!.copyWith(
                                      fontSize: 14, color: AppColors.redy),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  height: 45,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.red1,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              ImgRoots.info,
                                              height: 15,
                                              width: 15,
                                              fit: BoxFit.cover,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Haqida",
                                            style: CustomStyles.pageTitle!
                                                .copyWith(fontSize: 14),
                                          ),
                                          Text(
                                            "Version 1.2",
                                            style: CustomStyles.popText.copyWith(
                                                fontSize: 10, color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.navigate_next,
                                        size: 30,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.red1,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Hisobdan chiqish",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    })
     ;
  }
}

