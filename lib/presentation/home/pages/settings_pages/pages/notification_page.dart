import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/notification_page_controller.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final controller = Get.find<NotificationPageController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<NotificationPageController>();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationPageController>(builder: (_)
    {
      return Scaffold();
    });
  }
}
