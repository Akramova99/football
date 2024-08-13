import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/notification_page_controller.dart';
import 'package:football/presentation/widgets/notification_widget.dart';
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
    controller.getNotification();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<NotificationPageController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationPageController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Bildirishnomalar",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: controller.notifications.isNotEmpty
            ? ListView.builder(
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  var notification = controller.notifications[index];
                  return GestureDetector(
                    key: UniqueKey(),
                    onTap: () {
                      controller.removeNotification(notification);
                      showNotif(context, notification);
                    },
                    child: NotificationWidget(
                      key: ValueKey(notification.title),
                      notification: notification,
                    ),
                  );
                },
              )
            : const Center(
                child: Text("Sizda bildirishnomalr yoq"),
              ),
      );
    });
  }
}
