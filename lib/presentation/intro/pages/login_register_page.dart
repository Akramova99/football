import 'package:flutter/material.dart';
import 'package:football/presentation/intro/controllers/login_register_controller.dart';
import 'package:football/presentation/widgets/base_button.dart';
import 'package:football/utils/constants/styles.dart';

import 'package:get/get.dart';

import '../../widgets/login_register_bottom_shit.dart';
import '../../widgets/toast.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final LoginRegisterController controller =
      Get.find<LoginRegisterController>();

  @override
  void initState() {
    super.initState();

    controller.getTeamId();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginRegisterController>(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    width: double.infinity,
                    "assets/images/intro/login_img.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(flex: 5, child: Container())
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        )),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                         Text(
                          "Futboll haqida hamma narsani bilib oling!",
                          style: CustomStyles.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Nimani kutyapsiz? Keling, boshlaylik!",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(101, 101, 107, 1),fontFamily: "Poppins"),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        BaseButton(text: "Kirish", onPress: (){    loginBottomShit(
                            context: context,
                            controller: controller);}, icon: Icons.login, color: 1,),
                        const SizedBox(
                          height: 10,
                        ),
                        BaseButton(text: "Ro'yhatdan o'tish", onPress: (){
                          controller.teamId != null
                              ? registerBottomShit(
                              context: context,
                              controller: controller)
                              : ToastService.showError(
                              "Sizda jamoma mavjud emas");
                        }, icon: Icons.person_add, color: 0.6,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
