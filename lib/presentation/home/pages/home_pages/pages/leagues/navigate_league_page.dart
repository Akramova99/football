import 'package:flutter/material.dart';

import '../../../../../../utils/constants/img_roots.dart';
import '../../../../../../utils/constants/styles.dart';
import 'extra_leagues.dart';
class NavigateLeaguePage extends StatelessWidget {
  const NavigateLeaguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Center(
            child: Positioned(
              top: 0,
              child: Image.asset(
                ImgRoots.bg3,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
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
                      "Premier league",
                      style: CustomStyles.appBarStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1, // Matnni bitta qatorda cheklash
                    ),

                    Spacer(),
                  ],
                ),

              ),
              const ExtraLeaguesPage(),
            ],
          )
        ],
      ),
    );
  }
}
