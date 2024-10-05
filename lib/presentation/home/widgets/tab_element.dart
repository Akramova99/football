import 'package:flutter/material.dart';

class TabElement
    extends StatelessWidget {
  final String text;
  final Function onPress;
  final String  imgPath;

  const TabElement
      ({super.key, required this.text, required this.onPress,required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onPress(),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              Image.asset("assets/images/home/$imgPath.png",width: 279,height: 136,),
            ],
          ),//
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 120,
              ),
              Image.asset("assets/images/home/famous_p.png",width: 127,height: 151,),

            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(text,style: TextStyle(color: Colors.white),),
              ),
            ],
          )
        ],
      ),
    );
  }
}






