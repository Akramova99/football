import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/notification_page_controller.dart';
import 'package:football/presentation/widgets/notification_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/img_roots.dart';

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
        body: Stack(
          children: [
            Image.asset(
              ImgRoots.bg1,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios)),
                          Spacer(),
                          Text(
                            "Bildirishnomalar",
                            style: CustomStyles.appBarStyle,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    controller.notifications.isNotEmpty
                        ? ListView.builder(
                         shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.notifications.length,
                      itemBuilder: (context, index) {
                        var notification = controller.notifications[index];
                        return GestureDetector(
                          key: UniqueKey(),
                          onTap: () {

                            showNotif(context, notification);
                            controller.removeNotification(notification);
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
                  ],
                ),
              ),
            )
          ],
        ),
      );


    });
  }
}
