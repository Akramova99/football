import 'package:football/models/notification_model.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class NotificationPageController extends GetxController {
  late String userId;

  NotificationModel notificationModel = NotificationModel();
  List<FirebaseNotification> notifications = [];

  getNotification() async {
    userId = DbService.getUserId();
    print(userId);
    var path = "/api/v1/users/$userId/notifications?page=0&size=100";
    var response = await DioService.dio.get<String>(path);

    if (response.statusCode == 200) {
      if (response.data != null) {
        var list = notificationModelFromJson(response.data!);
        notifications = list.notifications!;
        update();
      }
    }
  }

  removeNotification(FirebaseNotification notification) async {
    var path = "/api/v1/users/notifications/${notification.id}";
    var response = await DioService.dio.get(path);
    if (response.statusCode == 200) {
      notifications.remove(notification);
      update();

    }
  }
}
