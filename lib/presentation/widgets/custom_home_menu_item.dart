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
        height: 40, decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: const Color.fromRGBO(246, 246, 246, 1), width: 2),
        ),
        padding: const EdgeInsets.all(10),
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                data["image"]!,
                fit: BoxFit.cover,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data["label"]!,
              style: const TextStyle(
                  fontSize: 12, color: Colors.white),
            ),

          ],
        ),
      ),
    );
  }
}


