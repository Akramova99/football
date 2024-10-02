import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/balance_page_controller.dart';
import 'package:football/presentation/home/widgets/balance_widget.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:get/get.dart';

import '../../../utils/constants/img_roots.dart';
import '../../../utils/constants/styles.dart';
import '../widgets/bar_chart_sample.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final controller = Get.find<BalancePageController>();
  int? selectedIndex;
  int selectedWidgetIndex = -1;

  @override
  void initState() {
    super.initState();
    controller.getUserData();
    controller.getTransferPackets();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BalancePageController>(builder: (_) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
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
                        "Balans",
                        style: CustomStyles.pageTitle,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImgRoots.balance,
                          width: 36,
                          height: 36,
                          color: AppColors.baseColor,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Text(
                            "12,580",
                            style: CustomStyles.pageTitle!.copyWith(
                                color: AppColors.HRed,
                                fontSize: 32,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 17, left: 40, right: 40),
                      height: 55,
                      width: 327,
                      decoration: BoxDecoration(
                        color: AppColors.cE8E8E8,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TabBar(
                          labelStyle: CustomStyles.dataTitle,
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          dividerHeight: 0,
                          indicator: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tabs: const [
                            Tab(
                              text: "   Price Transfers     ",
                            ),
                            Tab(
                              text: "         History          ",
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 800,
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Wrap(
                                  spacing: 10,
                                  // Space between widgets horizontally
                                  runSpacing: 10,
                                  // Space between widgets vertically
                                  children: [
                                    BalanceWidget(
                                      colors: AppColors.HRed.withOpacity(0.85),
                                      iconImg: "transfer",
                                      isExpanded: selectedWidgetIndex == 0,
                                      onTap: () {
                                        setState(() {
                                          selectedWidgetIndex =
                                              selectedWidgetIndex == 0 ? -1 : 0;
                                        });
                                      },
                                      index: 0,
                                    ),
                                    BalanceWidget(
                                      colors: AppColors.HRed.withOpacity(0.45),
                                      iconImg: "transfer",
                                      isExpanded: selectedWidgetIndex == 1,
                                      onTap: () {
                                        setState(() {
                                          selectedWidgetIndex =
                                              selectedWidgetIndex == 1 ? -1 : 1;
                                        });
                                      },
                                      index: 1,
                                    ),
                                    BalanceWidget(
                                      colors: AppColors.HRed,
                                      iconImg: "transfer",
                                      isExpanded: selectedWidgetIndex == 2,
                                      onTap: () {
                                        setState(() {
                                          selectedWidgetIndex =
                                              selectedWidgetIndex == 2 ? -1 : 2;
                                        });
                                      },
                                      index: 2,
                                    ),
                                    BalanceWidget(
                                      colors: Colors.white,
                                      iconImg: "price",
                                      isExpanded: selectedWidgetIndex == 3,
                                      onTap: () {
                                        setState(() {
                                          selectedWidgetIndex =
                                              selectedWidgetIndex == 3 ? -1 : 3;
                                        });
                                      },
                                      index: 3,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Second Tab (No changes needed)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BarChartSample1(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 15),
                                child: Text(
                                  "Harajatlar",
                                  style: CustomStyles.dataTitle!.copyWith(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(14),
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CircleAvatar(
                                                    child: Icon(
                                                      Icons.arrow_upward,
                                                      color: Colors.white,
                                                    ),
                                                    backgroundColor:
                                                        AppColors.green, //
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Balance Full",
                                                          style: CustomStyles
                                                              .dataTitle!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14)),
                                                      Text("Balance Full",
                                                          style: CustomStyles
                                                              .dataTitle!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .chartC2,
                                                                  fontSize:
                                                                      12)),
                                                    ],
                                                  ),
                                                  Text("+\$1,323.00",
                                                      style: CustomStyles
                                                          .dataTitle!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .green,
                                                              fontSize: 18)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    child: VerticalDivider(),
                                                    height: 17,
                                                  ),
                                                  SizedBox(
                                                    child: Divider(),
                                                    width: 260,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CircleAvatar(
                                                    child: Icon(
                                                      Icons.arrow_downward,
                                                      color: Colors.white,
                                                    ),
                                                    backgroundColor:
                                                        AppColors.light_red, //
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Transfer sotib olindi",
                                                          style: CustomStyles
                                                              .dataTitle!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14)),
                                                      Text(
                                                          "Tranfer uchun ishlatilindi",
                                                          style: CustomStyles
                                                              .dataTitle!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .chartC2,
                                                                  fontSize:
                                                                      12)),
                                                    ],
                                                  ),
                                                  Text("-\$150.00",
                                                      style: CustomStyles
                                                          .dataTitle!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .light_red,
                                                              fontSize: 18)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    child: VerticalDivider(),
                                                    height: 17,
                                                  ),
                                                  SizedBox(
                                                    child: Divider(),
                                                    width: 260,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )

                                    // Expense Details...
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
// Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Balans",
//             style: CustomStyles.pageTitle,
//           ),
//         ),
//         body: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   const Text(
//                     "Hisobimda :",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "${controller.user.balance ?? ""}",
//                     style: const TextStyle(
//                         fontSize: 16, color: Color.fromRGBO(34, 245, 0, 1)),
//                   )
//                 ],
//               ),
//               Expanded(
//                 child: ListView(
//                   controller: ScrollController(),
//                   children: List.generate(
//                     controller.packets.length,
//                     (index) {
//                       TransferPacketModel packet = controller.packets[index];
//                       return BalanceButton(
//                         title: packet.name ?? "",
//                         coins: packet.coinValue ?? 0,
//                         itemIndex: index + 1,
//                         chosenIndex: controller.index,
//                         onPress: controller.onPacketChosen,
//                         cost: packet.cost ?? 0,
//                         transferNumber: packet.numberOfTransfers!,
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//        )
