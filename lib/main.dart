import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/app.dart';
import 'package:get/get.dart';

import 'src/binding/init_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black),
            )),
        initialBinding: InitBinding(),
        home: const App());
  }
}
