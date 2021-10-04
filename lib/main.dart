import 'package:flutter/material.dart';
import 'package:flutter_beacon_listen/binding/app_binding.dart';
import 'package:flutter_beacon_listen/view/home_page.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      title: 'Flutter Beacon Listen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
