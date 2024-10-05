import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/my_team_controller.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/styles.dart';

class TeamNameWidget extends StatelessWidget {
  const TeamNameWidget({
    super.key,
    required this.icon,
    required this.name,
  });

  final String? name;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(94, 129, 58, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                10,
              ),
              topRight: Radius.circular(10))),
      child: Row(
        children: [
          Text(
            name ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            width: 10,
          ),
          CachedNetworkImage(
            height: 20,
            width: 20,
            imageUrl: icon ?? "",
            placeholder: (context, url) => Container(
              color: Colors.grey,
            ),
            errorWidget: (context, url, error) => Container(),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class TeamNameWidget2 extends StatelessWidget {
  const TeamNameWidget2({
    super.key,
    required this.icon,
    required this.name,
    required this.controller,
  });

  final MyTeamController controller;
  final String? name;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: AppColors.field.withOpacity(0.45),
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(
                10,
              ),
              bottomLeft: Radius.circular(10))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              name ?? "",
              style: CustomStyles.pageTitle!.copyWith(color: Colors.white),
            ),
          ),
          Spacer(),
          CachedNetworkImage(
            height: 32,
            width: 27,
            fit: BoxFit.cover,
            imageUrl: icon ?? "",
            placeholder: (context, url) {
              print("+++++++++++++++++++++++");
              return Stack(
                children: [
                  Image.asset(
                    "assets/images/settings/default_img.png",
                    width: 54,
                    height: 54,
                  ),
                ],
              );
            },
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/settings/default_img.png",
              width: 54,
              height: 54,
            ),
          ),
        ],
      ),
    );
  }
}
