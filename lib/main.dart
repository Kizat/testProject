import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/bindings/main_binding.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_project/routes/main_routes.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MainBinding(),
      title: 'TestProject',
      debugShowCheckedModeBanner: false,

      /// [Навигация]
      onGenerateRoute: MainRoutes.navigationController,
      initialRoute: MainRoutes.users,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
