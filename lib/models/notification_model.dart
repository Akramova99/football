// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  List<FirebaseNotification>? notifications;
  int? unseen;

  NotificationModel({
    this.notifications,
    this.unseen,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    notifications: json["notifications"] == null ? [] : List<FirebaseNotification>.from(json["notifications"]!.map((x) => FirebaseNotification.fromJson(x))),
    unseen: json["unseen"],
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "unseen": unseen,
  };
}

class FirebaseNotification {
  int? id;
  String? title;
  String? body;
  String? image;
  DateTime? createdDate;
  bool? viewed;

  FirebaseNotification({
    this.id,
    this.title,
    this.body,
    this.image,
    this.createdDate,
    this.viewed,
  });

  factory FirebaseNotification.fromJson(Map<String, dynamic> json) => FirebaseNotification(
    id: json["id"],
    title: json["title"],
    body: json["body"]!,
    image: json["image"]!,
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    viewed: json["viewed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "image": image,
    "createdDate": createdDate?.toIso8601String(),
    "viewed": viewed,
  };
}


