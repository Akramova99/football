import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/utils/constants/app_colors.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final IconData icon;
  final double color ;

  const BaseButton({super.key, required this.text, required this.onPress,required this.icon,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:   BoxDecoration(
          color: AppColors.HRed.withOpacity(color),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 13,fontFamily: "Poppins",fontWeight: FontWeight.w500),
            ),
            Icon(icon,color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
