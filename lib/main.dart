import 'package:flutter/material.dart';
import 'package:weatherly/screens/home_page.dart';
import 'package:weatherly/screens/screen2.dart';
import 'package:weatherly/screens/screen_1.dart';

void main() {
  runApp(Weatherly());
}

class Weatherly extends StatelessWidget {
  const Weatherly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Screen1(),
    );
  }
}
