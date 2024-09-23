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
       child:

        Image(
          color:isSelected? Colors.white:Colors.white.withOpacity(0.22),
              image: AssetImage(data["image"]!,),
              height: 30,
            ),
    );
  }
}
