import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/home_page_controller.dart';
import 'package:football/presentation/widgets/custom_home_menu_item.dart';
import 'package:football/presentation/widgets/time_display_widget.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<HomePageController>();

  @override
  void initState() {
    super.initState();
    controller.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (_) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 3),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Image.asset(
                "assets/images/home/appbar_right.png",
                height: 30,
              ),
            )
          ],
          leading: Container(
            margin: EdgeInsets.only(left: 20),
            child: Image.asset(
              "assets/images/home/appbar_left.png",
              height: 30,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi ${controller.name}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Good ${controller.dayTime}",
                style: const TextStyle(
                    fontSize: 16, color: Color.fromRGBO(155, 155, 155, 1)),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                child: TimeDisplay(
                  controller: controller,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  5,
                  (index) => CustomHomeMenuItem(
                    data: homeMenuItems[index],
                  ),
                ),
              ))
            ],
          ),
        ),
      );
    });
  }
}
