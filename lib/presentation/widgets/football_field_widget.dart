import 'package:flutter/material.dart';

class FootballFieldWidget extends StatelessWidget {
  const FootballFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1501 / 2400,
              child: Image(
                image: AssetImage("assets/images/team/football_field.png"),
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ],
    );
  }
}
