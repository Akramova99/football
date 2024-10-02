import 'package:flutter/material.dart';
import 'package:football/presentation/intro/pages/login_register_page.dart';
import 'package:football/presentation/intro/pages/select_team_name_page.dart';
import 'package:football/utils/constants/app_colors.dart';

class IntroPag extends StatelessWidget {
  final Map<String, String> introData;
  final bool isSkip;

  const IntroPag({super.key, required this.introData, required this.isSkip});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(

                  // height: 300,
                  child: Image(image: AssetImage(introData['image']!))),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isSkip
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginRegisterPage(),
                              ),
                            );
                          },
                          child:  const Text(
                            "Skip",
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: AppColors.baseColor,
                                decorationColor: AppColors.baseColor),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                introData['title']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  introData['text']!,
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromRGBO(60, 60, 60, 1)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
