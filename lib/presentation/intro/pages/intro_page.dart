import 'package:flutter/material.dart';

class IntroPag extends StatelessWidget {
  final Map<String, String> introData;

  const IntroPag({super.key, required this.introData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 300,
              child: Image(image: AssetImage(introData['image']!))),
          const SizedBox(
            height: 100,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  introData['title']!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 185, 0, 1)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  introData['text']!,
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromRGBO(60, 60, 60, 1)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
