import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/presentation/home/pages/base_page.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/leagues_page.dart';
import 'package:football/presentation/intro/pages/base_intro_page.dart';
import 'package:football/root/root_binding.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/firebase_notification_service.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyD-VXhyMASWm2YHvWm8JaHAAHtiLq2bbho",
    // paste your api key here
    appId: "1:631841810321:android:c5e088404e2c91fa635c30",
    //paste your app id here
    messagingSenderId: "631841810321",
    //paste your messagingSenderId here
    projectId: "uefa-aac18",
  ));
  await DbService.init();
  await FirebaseNotificationService.initNotification();
  FirebaseMessaging.onBackgroundMessage(
      FirebaseNotificationService.firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360.0, 765.0),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:
          DbService.getLoggedIn() ? const BasePage():
          const BaseIntroPage(),
          initialBinding: RootBinding(),
          routes: {
            '/a': (context) => LeaguesPage(),
          },
        );
      },
    );
  }
}
