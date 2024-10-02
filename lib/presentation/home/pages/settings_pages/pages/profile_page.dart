import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/profile_page_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/img_roots.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.find<ProfilePageController>();

  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ProfilePageController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(builder: (_) {
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
                            "Profile  ",
                            style: CustomStyles.appBarStyle,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.zero,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
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
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ]),
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: controller.profileImage != null
                                            ? Image.network(
                                                controller.profileImage!,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                color: Colors.grey,
                                              ),
                                      ),
                                    ),

                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(26),
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        color: Colors.orange,
                                      ),
                                      child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          controller.chooseImage();
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),



                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 17.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      controller.name != null ? controller.name! : "",
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      "+998 95 058 71 99",
                                      style: CustomStyles.dataTitle!.copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              // TextField(
                              //   controller: controller.nameCont,
                              //   decoration: InputDecoration(
                              //       hintText: "Nickname o’zgartirish",
                              //       border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(10),
                              //           borderSide: const BorderSide(
                              //               color: Colors.grey, width: 0.1))),
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // TextField(
                              //   controller: controller.phoneNumberCont,
                              //   keyboardType: TextInputType.phone,
                              //   inputFormatters: [controller.phoneNumberMask],
                              //   decoration: InputDecoration(
                              //       hintText: "Raqamni o’zgartirish",
                              //       border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(10),
                              //           borderSide: const BorderSide(
                              //               color: Colors.grey, width: 0.1))),
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // Container(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: 10, vertical: 2),
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10),
                              //       border: Border.all(
                              //           color: Colors.black, width: 0.5)),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         child: TextField(
                              //           controller: controller.passwordCont,
                              //           obscureText: controller.showPassword,
                              //           decoration: const InputDecoration(
                              //               hintText: "Parolni o’zgartirish",
                              //               border: InputBorder.none),
                              //         ),
                              //       ),
                              //       IconButton(
                              //         alignment: Alignment.center,
                              //         onPressed: () {
                              //           controller.hidePassword();
                              //         },
                              //         icon: controller.showPassword
                              //             ? const Icon(Icons.visibility)
                              //             : const Icon(Icons.visibility_off),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              Container(
                                height: 64,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controller.nameCont,
                                        cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                                        decoration: InputDecoration(
                                            icon: Image.asset(
                                              "assets/images/intro/username_img.png",
                                              height: 20,
                                              width: 20,
                                            ),
                                            border: InputBorder.none,
                                            hintText: "Taxallus",
                                            hintStyle: TextStyle(fontFamily: "Poppins")

                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 64,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/intro/phone.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        inputFormatters: [controller.phoneNumberMask],
                                        controller: controller.phoneNumberCont,
                                        cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "+998",
                                        ),
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 64,
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controller.passwordCont,
                                        cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                                        obscureText: controller.showPassword,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            icon: Image.asset(
                                              "assets/images/intro/password_img.png",
                                              width: 20,
                                              height: 20,
                                            ),
                                            hintText: "Password",
                                            hintStyle: TextStyle(fontFamily: "Poppins"),
                                            suffixIcon: IconButton(
                                              icon: controller.showPassword
                                                  ? const Icon(Icons.visibility)
                                                  : const Icon(Icons.visibility_off),
                                              onPressed: controller.hidePassword,
                                            )),
                                        keyboardType: TextInputType.visiblePassword,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              CustomButton(
                                text: "Saqlash",
                                onPress: () {
                                  controller.updateUserData();
                                },
                                color: AppColors.baseColor,
                              )
                            ],
                          ),
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
    });
  }
}
