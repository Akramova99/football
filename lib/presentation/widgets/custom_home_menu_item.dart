import 'package:flutter/material.dart';

class CustomHomeMenuItem extends StatelessWidget {
  final Map data;

  const CustomHomeMenuItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return data['rout'];
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: const Color.fromRGBO(246, 246, 246, 1), width: 2),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Image.asset(
                data["image"]!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data["label"]!,
              style: const TextStyle(
                  fontSize: 20, color: Color.fromRGBO(51, 51, 51, 1)),
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

class CustomHomeMenuItem2 extends StatelessWidget {
  final Map data;
  final Function changeLanguage;

  const CustomHomeMenuItem2(
      {super.key, required this.data, required this.changeLanguage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeLanguage();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: const Color.fromRGBO(246, 246, 246, 1), width: 2),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Image.asset(
                data["image"]!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data["label"]!,
              style: const TextStyle(
                  fontSize: 20, color: Color.fromRGBO(51, 51, 51, 1)),
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
