import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football/utils/constants/app_colors.dart';

class CreateButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color ;

  const CreateButton({super.key, required this.text, required this.onPress,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:   BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/league/add.svg",color: Colors.white,),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 13,fontFamily: "Poppins",fontWeight: FontWeight.w500),
            ),

          ],
        ),
      ),
    );
  }
}
