import 'package:flutter/material.dart';
import 'package:football/presentation/widgets/custom_button.dart';

loginBottomShit(BuildContext context,{required Function login}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
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
                        border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(0, 0, 0, 0.25)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: Color.fromRGBO(0, 0, 0, 0.25),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
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
                        border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(0, 0, 0, 0.25)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: Color.fromRGBO(0, 0, 0, 0.25),
                            decoration: InputDecoration(
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
                  CustomButton(text: "Kirish", onPress: () {
                    login();
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
                          registerBottomShit(context,register: ()=>{});
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

registerBottomShit(BuildContext context, {required Function register}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
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
                        border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(0, 0, 0, 0.25)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(0, 0, 0, 0.25)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: const Color.fromRGBO(0, 0, 0, 0.25),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
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
                        border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(0, 0, 0, 0.25)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
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
                        ///checkbox
                        value: true,
                        onChanged: (result) {},
                      ),
                      Text("Eslab qolish")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(text: "Ro'yhatdan o'tish", onPress: () {
                    register();
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
                          loginBottomShit(context,login: (){});
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
