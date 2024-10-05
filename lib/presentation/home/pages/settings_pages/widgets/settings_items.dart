import 'package:flutter/material.dart';
import 'package:football/utils/constants/styles.dart';

import '../../../../../utils/constants/app_colors.dart';
import 'package:get/get.dart';



class SettingsItem extends StatelessWidget {
  final Map data;
  final Map<String,String> data2;
  final Function changeLanguage;

  const SettingsItem(
      {super.key, required this.data, required this.changeLanguage,required this.data2});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeLanguage();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5,),
        height: 45,


        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.baseColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),

              ) ,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  height: 15,
                  width: 15,
                  data["image"]!,
                  fit: BoxFit.cover,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data2["label"]!.tr,
                  style: CustomStyles.pageTitle!.copyWith(fontSize: 14),
                ),
                Text(
                  data2["label"]!.tr,
                  style: CustomStyles.popText.copyWith(fontSize: 10,color: AppColors.purple),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.navigate_next,
              size: 30,
              color: Color.fromRGBO(51, 51, 51, 1),
            )
          ],
        ),
      ),
    );
  }
}
