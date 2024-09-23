import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/utils/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const CustomButton({super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:  const BoxDecoration(
          color: AppColors.HRed,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 13,fontFamily: "Poppins"),
        ),
      ),
    );
  }
}
