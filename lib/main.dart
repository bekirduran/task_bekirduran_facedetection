import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model/utils/home_binding.dart';
import 'view/pages/home_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBindings(),
      home: HomePage(),
    );
  }
}


