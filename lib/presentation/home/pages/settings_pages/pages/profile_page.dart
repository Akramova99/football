import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/profile_page_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.find<ProfilePageController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: CustomStyles.pageTitle,
        ),
      ),
      body: GetBuilder<ProfilePageController>(
        builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: controller.profileImage != null
                            ? Image.network(controller.profileImage!)
                            : Container(
                                color: Colors.grey,
                              ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.orange,
                        ),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            size: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.name != null ? controller.name! : "",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(

                  decoration: InputDecoration(
                    hintText: "Nickname o’zgartirish",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 0.1))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Raqamni o’zgartirish",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 0.1))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Parolni o’zgartirish",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 0.1))),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(text: "Saqlash", onPress: () {})
              ],
            ),
          );
        },
      ),
    );
  }
}
