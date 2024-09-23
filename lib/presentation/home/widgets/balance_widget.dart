import 'package:flutter/material.dart';
import 'package:football/utils/constants/styles.dart';

class BalanceWidget extends StatelessWidget {
  final Function onTap;
  final Color colors;
  final String iconImg;

  const BalanceWidget(
      {super.key,
      required this.colors,
      required this.onTap,
      required this.iconImg});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap(),
        child: Container(
          width: 150,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 16),
          height: 127,
          decoration: BoxDecoration(
              color: colors, borderRadius: BorderRadius.circular(6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/balance/$iconImg.png",
                    height: 24,
                  ),
                  Image.asset("assets/images/balance/star.png", height: 24,color: iconImg=="price"?Color(0xff929393):Colors.white,),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(//#929393
                    "1ta Tranfer",
                    style: CustomStyles.dataTitle!.copyWith(color: iconImg=="price"?Colors.black:Colors.white,fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Sale -30%",
                    style: CustomStyles.dataTitle!.copyWith(color: iconImg=="price"?Color(0xff929393):Colors.white,fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
