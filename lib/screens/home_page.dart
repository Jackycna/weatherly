import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherly/screens/screen_1.dart';
import 'package:weatherly/service/location.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (mounted) {
      getLocation();
    }
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCutrrentLocation();
    double lattitude = location.lattitude;
    double longitude = location.longitute;
    var apiKey = "c5569611bbd1d07c7926fb054dec975c";
    var apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={c5569611bbd1d07c7926fb054dec975c}";
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': lattitude.toString(),
      'lon': longitude.toString(),
      'appid': apiKey,
    });
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Screen1()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SpinKitDoubleBounce(color: Colors.red, size: 50)),
    );
  }
}
