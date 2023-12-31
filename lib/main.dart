import 'package:expencetracker/ExploreScreen.dart';
import 'package:expencetracker/HomeScreen.dart';
import 'package:flutter/material.dart';

import 'EditHomeScreen.dart';
import 'MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Replace super.key with Key? key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: ExploreScreen(),
    );
  }
}
