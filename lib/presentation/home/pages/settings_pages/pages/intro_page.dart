import 'package:flutter/material.dart';
import 'package:football/utils/constants/constants.dart';

import '../../../../../utils/constants/img_roots.dart';
import '../../../../../utils/constants/styles.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                          "Fantasy football introduction",
                          style: CustomStyles.appBarStyle,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Text(intro_text),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );


  }
}
