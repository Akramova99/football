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
    return GetBuilder<LoginRegisterController>(builder: (_){
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 291 / 338,
                child: Image.asset("assets/images/intro/login_img.png"),
              ),
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
              const Text(
                "Nimani kutyapsiz? Keling, boshlaylik!",
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(101, 101, 107, 1)),
                textAlign: TextAlign.start,
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(16))),
                          child: MaterialButton(
                            onPressed: () {
                              loginBottomShit(
                                  context: context, controller: controller);
                            },
                            textColor: Colors.white,
                            child: const Text(
                              "Kirish",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.teamId != null
                                ? registerBottomShit2(
                                context: context, controller: controller)
                                : ToastService.showError(
                                "Sizda jamoma mavjud emas");
                          },
                          child: const Text(
                            "Royhatdan o’tish",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(196, 196, 196, 1)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
