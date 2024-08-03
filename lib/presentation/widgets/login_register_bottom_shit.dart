import 'package:flutter/material.dart';
import 'package:football/presentation/intro/controllers/login_register_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/presentation/widgets/toast.dart';

loginBottomShit(
    {required BuildContext context,
    required LoginRegisterController controller}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hush kelibsiz!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                            controller: controller.emailLog,
                            cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone number",
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
                            controller: controller.passwordLog,
                            cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {},
                      ),
                      Text("Eslab qolish")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Kirish",
                      onPress: () {
                        controller.login(context);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Akkauntingiz bo’rmi?",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: const Text(
                          "Ro’yhatdan o’tish!",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          controller.teamId != null
                              ? registerBottomShit(
                                  context: context, controller: controller)
                              : ToastService.showError(
                                  "Sizda jamoma mavjud emas");
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

registerBottomShit(
    {required BuildContext context,
    required LoginRegisterController controller}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              color: const Color.fromRGBO(246, 243, 248, 1),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hush kelibsiz!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                            controller: controller.userNameReg,
                            cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                            controller: controller.emailReg,
                            cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone number",
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
                            controller: controller.passwordReg,
                            cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                            obscureText: controller.showPassword,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.email),
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  icon: controller.showPassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onPressed: () {},
                                )),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        ///checkbox
                        value: true,
                        onChanged: (result) {},
                      ),
                      const Text("Eslab qolish")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Ro'yhatdan o'tish",
                      onPress: () {
                        controller.register(context);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Akkauntingiz bo’rmi?",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: const Text(
                          "Kirish!",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          loginBottomShit(
                              controller: controller, context: context);
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

registerBottomShit2(
    {required BuildContext context,
    required LoginRegisterController controller}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return RegisterBottomSheet(controller: controller);
      });
}

class RegisterBottomSheet extends StatelessWidget {
  const RegisterBottomSheet({super.key, required this.controller});

  final LoginRegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(246, 243, 248, 1),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hush kelibsiz!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
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
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.userNameReg,
                        cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username",
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.emailReg,
                        cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone number",
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
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.passwordReg,
                        cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                        obscureText: controller.showPassword,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.email),
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: controller.showPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                controller.hidePassword();
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    ///checkbox
                    value: true,
                    onChanged: (result) {},
                  ),
                  const Text("Eslab qolish")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: "Ro'yhatdan o'tish",
                  onPress: () {
                    controller.register(context);
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Akkauntingiz bo’rmi?",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Text(
                      "Kirish!",
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      loginBottomShit(controller: controller, context: context);
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
