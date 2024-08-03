import 'package:flutter/material.dart';
import 'package:football/utils/constants/styles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Bildirishnomalar", style: CustomStyles.pageTitle,),
    ),
    body: Center(child: Text("Sizda bildirish nomalar yo'q"),),);
  }
}
