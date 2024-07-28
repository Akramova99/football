import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final bool isSelected;
  final Map<String, String> data;



  const CustomBottomNavigationItem(
      {super.key, required this.isSelected, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isSelected
          ? Column(
              children: [
                Text(
                  data['label']!,
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 185, 0, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset("assets/images/bottom_navigation/point.png")
              ],
            )
          : Image(
              image: AssetImage(data["image"]!),
              height: 30,
            ),
    );
  }
}
