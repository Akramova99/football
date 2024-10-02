// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/create_league_controller.dart';
// import 'package:football/presentation/home/pages/home_pages/pages/leagues/widgets/create_button.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../utils/constants/app_colors.dart';
// import '../../../../../../utils/constants/styles.dart';
//
// class CreateLeaguePage extends StatefulWidget {
//   const CreateLeaguePage({super.key});
//
//   @override
//   State<CreateLeaguePage> createState() => _CreateLeaguePageState();
// }
//
// class _CreateLeaguePageState extends State<CreateLeaguePage> {
//   final controller = Get.find<CreateLeagueController>();
//   bool isChooseImg = false;
//
//   @override
//   void initState() {
//     super.initState();
//     controller.getWeeks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CreateLeagueController>(builder: (_) {
//       return Scaffold(
//         body: SizedBox(
//           height: 516,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Liga Yaratish',
//                       style: CustomStyles.appBarStyle.copyWith(fontSize: 24),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 !isChooseImg
//                     ? InkWell(
//                   onTap: () async {
//                     await controller.chooseImage();
//                     isChooseImg = true  ;
//                     setState(() {});
//                   },
//                   child: Container(
//                     height: 65,
//                     width: 323,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(32),
//                       gradient: const LinearGradient(
//                         colors: [Colors.blue, Colors.purple],
//                         // Define your gradient colors
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                     ),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         // Adjust this to match the outer radius
//                         color: Colors
//                             .white, // Background color for the inner container
//                       ),
//                       margin: EdgeInsets.all(2), // Border width
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.image_outlined,
//                             color: AppColors.purple,
//                           ),
//                           Text(
//                             'Take Gallery (JPG,PNG)',
//                             style: CustomStyles.appBarStyle.copyWith(
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.purple,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//                     : Center(
//                   child: Stack(
//                     children: [
//                       SizedBox(
//                         child: ClipOval(
//                           child: CachedNetworkImage(
//                             imageUrl:"http://46.101.131.127:8080/api/v1/files/${controller.img}",
//                             width: 90,
//                             height: 87,
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) {
//                               print("+++++++++++++++++++++++");
//                               return Stack(
//                                 children: [
//                                   Image.asset(
//                                       "assets/images/home/player_img.png")
//                                 ],
//                               );
//                             },
//                             errorWidget: (context, url, error) =>
//                                 Image.asset(
//                                   "assets/images/home/player_img.png",
//                                   width: 54,
//                                 ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 60.0),
//                         child: IconButton(onPressed: (){
//                           isChooseImg = false;
//                           setState(() {
//
//                           });
//                         }, icon: const Icon(
//                           Icons.close_outlined,
//                           color: AppColors.redy,
//                         )),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   'Nomi',
//                   style: CustomStyles.appBarStyle
//                       .copyWith(fontWeight: FontWeight.w400),
//                 ),
//                 const SizedBox(height: 6.0),
//                 TextField(
//                   controller: controller.nameController,
//                   decoration: InputDecoration(
//                     label: Row(
//                       children: [
//                         const Icon(
//                           Icons.person_add_alt,
//                           size: 18,
//                           color: AppColors.purple,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           'Uzb cup',
//                           style: CustomStyles.appBarStyle.copyWith(
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.purple),
//                         ),
//                       ],
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 // TextField(
//                 //   controller: controller.description,
//                 //   decoration: InputDecoration(
//                 //     labelText: 'Description',
//                 //     border: OutlineInputBorder(
//                 //         borderRadius: BorderRadius.circular(10)),
//                 //   ),
//                 //   maxLines: 3,
//                 // ),
//                 const SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: DropdownButtonFormField<int>(
//                         key: const ValueKey("Start"),
//                         value: controller.leagueStart,
//                         decoration: InputDecoration(
//                           labelText: 'Start Liga',
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                         items: List.generate(
//                             controller.weeks.length, (index) => index + 1)
//                             .map((value) => DropdownMenuItem<int>(
//                           value: value,
//                           child: Text(
//                               "${controller.weeks[value - 1].weekNumber ?? ""}"),
//                         ))
//                             .toList(),
//                         onChanged: (newValue) {
//                           controller.onWeekChange(true, newValue!);
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 16.0),
//                     Expanded(
//                       child: DropdownButtonFormField<int>(
//                         key: const ValueKey("End"),
//                         value: controller.leagueEnd,
//                         decoration: InputDecoration(
//                           labelText: 'End Liga',
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                         items: List.generate(
//                             controller.weeks.length, (index) => index + 1)
//                             .map((value) => DropdownMenuItem<int>(
//                           value: value,
//                           child: Text(
//                               "${controller.weeks[value - 1].weekNumber ?? ""}"),
//                         ))
//                             .toList(),
//                         onChanged: (newValue) {
//                           controller.onWeekChange(false, newValue!);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24.0),
//                 CreateButton(
//                     text: "Liga yaratish",
//                     onPress: () {
//                       controller.createLeague(context);
//                     // },
//                     color: AppColors.cyan),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
//
