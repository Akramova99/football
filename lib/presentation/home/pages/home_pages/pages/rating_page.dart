import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/rating_page_controller.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final controller = Get.find<RatingPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reyting",
          style: CustomStyles.pageTitle,
        ),
      ),
      body: GetBuilder<RatingPageController>(builder: (_) {
        return Container();
      }),
    );
  }
}
