import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String button1Text;
  final String button2Text;
  final VoidCallback button1Function;
  final VoidCallback button2Function;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.button1Text,
    required this.button2Text,
    required this.button1Function,
    required this.button2Function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 16,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    button1Function();
                  },
                  child: Text(button1Text),
                ),
                ElevatedButton(
                  onPressed: () {
                    button2Function();
                  },
                  child: Text(button2Text),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Usage example
