import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/base_page.dart';
import 'package:football/presentation/intro/pages/base_intro_page.dart';
import 'package:football/root/root_binding.dart';
import 'package:football/services/db_service.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DbService.getLoggedIn() ? const BasePage() : const BaseIntroPage(),
      initialBinding: RootBinding(),
    );
  }
}
