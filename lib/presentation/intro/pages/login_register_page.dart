import 'package:flutter/material.dart';
import 'package:football/presentation/intro/controllers/login_register_controller.dart';
import 'package:football/presentation/widgets/login_register_bottom_shit.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:get/get.dart';

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
                  flex: 3,
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
                        const Text(
                          "Futboll haqida hamma narsani bilib oling!",
                          style: TextStyle(fontSize: 32),
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
                                  color: Color.fromRGBO(101, 101, 107, 1)),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 63,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(0, 185, 0, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    child: MaterialButton(
                                      onPressed: () {
                                        loginBottomShit(
                                            context: context,
                                            controller: controller);
                                      },
                                      textColor: Colors.white,
                                      child: const Text(
                                        "Kirish",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 63,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(0, 185, 0, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    child: MaterialButton(
                                      onPressed: () {
                                        controller.teamId != null
                                            ? registerBottomShit(
                                                context: context,
                                                controller: controller)
                                            : ToastService.showError(
                                                "Sizda jamoma mavjud emas");
                                      },
                                      textColor: Colors.white,
                                      child: const Text(
                                        "Ro'yhatdan o'tish",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
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
          ],
        ),
      );
    });
  }
}
