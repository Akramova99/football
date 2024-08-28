import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/home_page_controller.dart';
import 'package:football/presentation/widgets/custom_home_menu_item.dart';
import 'package:football/presentation/widgets/time_display_widget.dart';
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
          shadowColor: Colors.grey,
          elevation: 5,
          toolbarHeight: 100,
          primary: true,
          backgroundColor: const Color.fromRGBO(0, 185, 0, 1),
          title: Text(
            controller.name ?? "",
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 30),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        "assets/images/home/appbar_right.png",
                        height: 30,
                        width: 30,
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
                SizedBox(
                  width: double.infinity,
                  child: TimeDisplay(
                    controller: controller,
                  ),
                ),
                Image.asset("assets/images/home/central_img.png"),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    homeMenuItems.length,
                    (index) => index != 4
                        ? CustomHomeMenuItem(
                            data: homeMenuItems[index],
                          )
                        : CustomHomeMenuItem2(
                            data: homeMenuItems[4],
                            changeLanguage: () {
                              Navigator.pushNamed(context, "/a");
                            },
                          ),
                  ),
                ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
