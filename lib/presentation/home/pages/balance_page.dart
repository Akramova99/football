import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/balance_page_controller.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/profile_page_controller.dart';
import 'package:football/presentation/home/widgets/balance_widget.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:get/get.dart';

import '../../../utils/constants/img_roots.dart';
import '../../../utils/constants/styles.dart';
import '../widgets/bar_chart_sample.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_pages/controllers/transfer_page_controller.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final controller = Get.find<BalancePageController>();
  final controller2 = Get.find<TransferPageController>();
 final profileController = Get.find<ProfilePageController>(); // Get the profile controller

  int? selectedIndex;
  int selectedWidgetIndex = -1;

  @override
  void initState() {
    super.initState();
    controller.getUserData();
    controller.getTransferPackets();
    controller.getPaymentHistory();
    controller2.getTransferSummary();


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
                        "Balans".tr,
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
                          child:
                          GetBuilder<ProfilePageController>(builder: (_) {
                            profileController.getData();
                            return      Text(
                              "${profileController.user.coins??" "}",
                              style: CustomStyles.pageTitle!.copyWith(
                                  color: AppColors.HRed,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900),
                            );
                          }),


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
                          tabs:  [
                            Tab(
                              text: "   ${"Transfer narxi".tr}      ",
                            ),
                            Tab(
                              text: "         ${"Tarix".tr}          ",
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 800.h,
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
                                  "Harajatlar".tr,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     const CircleAvatar(
                                          //       child: Icon(
                                          //         Icons.arrow_upward,
                                          //         color: Colors.white,
                                          //       ),
                                          //       backgroundColor: AppColors.green, //
                                          //     ),
                                          //     Column(
                                          //       crossAxisAlignment: CrossAxisAlignment.start,
                                          //       children: [
                                          //         Text("Balansni to\'ldirish".tr,
                                          //             style: CustomStyles.dataTitle!.copyWith(
                                          //                 color: Colors.black, fontSize: 14)),
                                          //         Text("Balansni to\'ldirish".tr,
                                          //             style: CustomStyles.dataTitle!.copyWith(
                                          //                 color: AppColors.chartC2, fontSize: 12)),
                                          //       ],
                                          //     ),
                                          //     Text("+\$1,323.00",
                                          //         style: CustomStyles.dataTitle!.copyWith(
                                          //             color: AppColors.green, fontSize: 18)),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 8.h,
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          //   children: [
                                          //     SizedBox(
                                          //       child: VerticalDivider(),
                                          //       height: 17.h,
                                          //     ),
                                          //     SizedBox(
                                          //       child: Divider(),
                                          //       width: 260.w,
                                          //     ),
                                          //   ],
                                          // ),

                                          // ListView.builder qo'llaniladi
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(), // Scroll to'xtatilgan
                                            itemCount:  controller.payment.length,//controller.payment.isEmpty ? 1 :
                                            itemBuilder: (context, index) {

                                              var payment = controller.payment[index];
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const CircleAvatar(
                                                        child: Icon(
                                                          Icons.arrow_downward,
                                                          color: Colors.white,
                                                        ),
                                                        backgroundColor: AppColors.light_red, //
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Transfer sotib olindi".tr,
                                                              style: CustomStyles.dataTitle!.copyWith(
                                                                  color: Colors.black, fontSize: 14)),
                                                          Text("Tranfer uchun ishlatilindi".tr,
                                                              style: CustomStyles.dataTitle!.copyWith(
                                                                  color: AppColors.chartC2, fontSize: 12)),
                                                        ],
                                                      ),
                                                      Text("-\$${payment.amount}",
                                                          style: CustomStyles.dataTitle!.copyWith(
                                                              color: AppColors.light_red, fontSize: 18)),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        child: VerticalDivider(),
                                                        height: 17.h,
                                                      ),
                                                      SizedBox(
                                                        child: Divider(),
                                                        width: 260.w,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                ],
                                              );
                                            },
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

