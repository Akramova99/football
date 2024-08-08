// To parse this JSON data, do
//
//     final notificationResponseModel = notificationResponseModelFromJson(jsonString);

import 'dart:convert';

List<NotificationResponseModel> notificationResponseModelFromJson(String str) =>
    List<NotificationResponseModel>.from(
        json.decode(str).map((x) => NotificationResponseModel.fromJson(x)));

String notificationResponseModelToJson(List<NotificationResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationResponseModel {
  String id;
  String title;
  String body;
  String? image;
  DateTime? createdDate;
  bool viewed;

  NotificationResponseModel({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
    required this.createdDate,
    required this.viewed,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationResponseModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        image: json["image"],
        createdDate: DateTime.parse(json["createdDate"]),
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
