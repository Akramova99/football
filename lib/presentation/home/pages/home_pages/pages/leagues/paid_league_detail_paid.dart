import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/paid_leagu_detail_page_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:get/get.dart';

class PaidLeagueDetailPage extends StatefulWidget {
  final String id;

  const PaidLeagueDetailPage({super.key, required this.id});

  @override
  State<PaidLeagueDetailPage> createState() => _PaidLeagueDetailPageState();
}

class _PaidLeagueDetailPageState extends State<PaidLeagueDetailPage> {
  final controller = Get.find<PaidLeaguesDetailPageController>();

  @override
  void initState() {
    super.initState();
    controller.getLeague(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaidLeaguesDetailPageController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(0, 185, 0, 1),
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text(
              controller.league.name ?? "",
              style: const TextStyle(color: Colors.white),
            )),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: const Color.fromRGBO(50, 199, 50, 0.55),
              child: Text(
                controller.league.description ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            CachedNetworkImage(
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              imageUrl: controller.league.image ?? "",
              placeholder: (context, url) => Container(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.league.name ?? ""}(MW${controller.league.startWeek?.weekNumber ?? ""}-MW${controller.league.endWeek?.weekNumber}) ",
                        style: const TextStyle(
                            color: Color.fromRGBO(0, 185, 0, 1), fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Teams in",
                        style: TextStyle(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            fontSize: 13),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${controller.league.teams?.length ?? ""}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(text: "Ligaga qo'shilish", onPress: () {
                    controller.joinLeague(context);
                  })
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
