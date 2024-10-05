import 'package:flutter/material.dart';
import 'package:football/models/notification_model.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NotificationWidget extends StatefulWidget {
  final FirebaseNotification notification;

  const NotificationWidget({super.key, required this.notification});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  var isValid = false;

  @override
  void initState() {
    super.initState();
    _checkImageValidity(widget.notification.image);
  }

  Future<void> _checkImageValidity(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) {
      setState(() {
        isValid = false;
      });
      return;
    }

    final isValidImage = await validateImage(imageUrl);
    setState(() {
      isValid = isValidImage;
    });
  }

  Future<bool> validateImage(String imageUrl) async {
    try {
      final res = await http.get(Uri.parse(imageUrl));
      if (res.statusCode != 200) return false;

      final contentType = res.headers['content-type'];
      return checkIfImage(contentType);
    } catch (e) {
      return false;
    }
  }

  bool checkIfImage(String? contentType) {
    return contentType == 'image/jpeg' ||
        contentType == 'image/png' ||
        contentType == 'image/gif';
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.notification.title ?? "",
            style: const TextStyle(fontSize: 20),
          ),
           SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              if (isValid && widget.notification.image != null)
                SizedBox(
                  width: 150.w,
                  height: 140.h,
                  child: Image.network(
                    widget.notification.image!,
                    fit: BoxFit.cover,
                  ),
                ),
               SizedBox(
                width: 20.w,
              ),
              SizedBox(
                width: 120.w,
                child: Text(
                  maxLines: null,
                  widget.notification.body ?? "",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

showNotif(context, FirebaseNotification notification) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            // constraints: const BoxConstraints(
            //   minHeight: 450,
            //   maxHeight: 500,
            // ),
            height: 450.h,
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  notification.title ?? "",
                  style:  TextStyle(
                      fontSize: 20.h,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 10.h,
                ),
                if (notification.image != null)
                  Image.network(
                    notification.image!,
                    height: 200.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                  ),
                 SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  // height: 200,
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Text(notification.body ?? "",style: CustomStyles.dataTitle!.copyWith(color: Colors.black87),)),
                )
              ],
            ),
          ),
        );
      });
}
