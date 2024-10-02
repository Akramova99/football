import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/statistics/controllers/statistics_page_controller.dart';
import 'package:football/presentation/home/widgets/player_statistic_widget.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../../../utils/constants/img_roots.dart';
import '../../../../../utils/constants/styles.dart';
import '../../../../intro/controllers/create_team_controller.dart';
import '../../../widgets/dropdawn_buttons.dart';
import '../../home_pages/controllers/transfer_page_controller.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final controller = Get.find<StatisticsPageController>();
  final filter = Get.find<CreateTeamController>();

  String myValue= "Clubs";
  @override
  void didChangeDependencies() {
    filter.getClubs();
    controller.getStatistics(position: 'FORWARD', clubId: 1);
    Logger().w(controller.isCheck);
    super.didChangeDependencies();
  }
  // @override
  // void initState() {
  //   super.initState();
  //
  //   controller.getStatistics();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsPageController>(builder: (_) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(241, 241, 241, 1),
        body: Stack(
          children: [
            Image.asset(
              ImgRoots.bg1,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40.0,
                    ),
                    child: Text(
                      "O'yinchilar statistikasi",
                      style: CustomStyles.pageTitle,
                    ),
                  ),
                   const Row(
                    children: [
                      DropdownBut(text: "Clubs", isClub: true,),
                      DropdownBut(text: "Position", isClub: false,),

                    ],
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
Logger().e(controller.statics[index].playerName);
                        return PlayerStatisticWidget(
                          controller: controller,
                          index: index,
                        );
                      },
                      itemCount: controller.statics.length),
                  SizedBox(
                    height: 100,
                  ),

                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
// Container(
//   width: double.infinity,
//   margin: const EdgeInsets.all(10),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.all(Radius.circular(10)),
//     color: Colors.white,
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.2),
//         spreadRadius: 2,
//         blurRadius: 5,
//         offset: Offset(0, 3),
//       ),
//     ],
//   ),
//   child: SizedBox(
//     width: double.infinity,
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: DataTable(
//         columnSpacing: 40,
//         decoration: const BoxDecoration(color: Colors.white),
//         dividerThickness: 0.5,
//         columns: const [
//           DataColumn(label: Text('#')),
//           DataColumn(label: Text("O'yinchilar")),
//           DataColumn(label: Text('PTS')),
//           DataColumn(label: Text('')),
//         ],
//         rows: List.generate(
//           controller.players.length,
//               (index) {
//             return DataRow(cells: [
//               DataCell(
//                 Text((index + 1).toString()),
//               ),
//               DataCell(Row(
//                 children: [
//                   CachedNetworkImage(
//                     height: 20,
//                     width: 30,
//                     imageUrl: controller.players[index].jersey ?? "",
//                     placeholder: (context, url) => Container(),
//                     errorWidget: (context, url, error) => Container(),
//                   ),
//                   Text(controller.players[index].name ?? ""),
//                 ],
//               )),
//               DataCell(
//                   Text("${controller.players[index].score ?? "-"}")),
//               DataCell(
//                   const Icon(
//                     Icons.info_outline,
//                     color: Colors.green,
//                   ), onTap: () {
//                 controller.callPLayerDetailPage(
//                     controller.players[index], context);
//               }),
//             ]);
//           },
//         ),
//       ),
//     ),
//   ),
// ),