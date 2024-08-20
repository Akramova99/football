import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
          color: Colors.green,
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
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
