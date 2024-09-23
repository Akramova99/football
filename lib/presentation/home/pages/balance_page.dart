import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/models/transfer_maket_model.dart';
import 'package:football/presentation/home/controllers/balance_page_controller.dart';
import 'package:football/presentation/home/widgets/balance_widget.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:get/get.dart';

import '../../../utils/constants/img_roots.dart';
import '../../../utils/constants/styles.dart';
import '../../widgets/balance_button.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final controller = Get.find<BalancePageController>();

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
                      padding: const EdgeInsets.only(top: 40.0,),
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
                        height:36,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,),
                        child: Text(
                          "12,580",
                          style: CustomStyles.pageTitle!.copyWith(color: AppColors.HRed,fontSize: 32,fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],),
                    Container(
                      margin: EdgeInsets.only(top: 17, left: 40,right: 40),
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
                    SizedBox(height: 20,),

                    SizedBox(

                      width: double.infinity,
                      height: 800,
                      child: TabBarView(children: [
                       Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               BalanceWidget(colors: AppColors.HRed.withOpacity(0.85), onTap: (){ }, iconImg: "transfer"),
                               BalanceWidget(colors: AppColors.HRed.withOpacity(0.45), onTap: (){}, iconImg: "transfer"),
                             ],
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                             children: [
                               BalanceWidget(colors: AppColors.HRed, onTap: (){}, iconImg: "transfer"),
                               BalanceWidget(colors: AppColors.white, onTap: (){}, iconImg: "price"),
                             ],
                           ),
                         ],
                       ),
                       Container(),


                      ]),
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