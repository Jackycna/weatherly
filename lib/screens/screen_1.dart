import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherly/screens/screen2.dart';

class Screen1 extends StatefulWidget {
  final weatherdata;
  const Screen1({super.key, this.weatherdata});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  var apiKey = "c5569611bbd1d07c7926fb054dec975c";
  var cityName;
  var currentWeather;
  var tempIncel;
  var emoji = "";

  @override
  void initState() {
    // UpdateUi(widget.weatherdata);
    super.initState();
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/city.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      print(widget.weatherdata['weather'][0]['main']);
                      UpdateUi(widget.weatherdata);
                    },
                    icon: Icon(Icons.near_me, size: 50, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Screen2()),
                      );
                      if (cityName != Null || cityName != "") {
                        var weatherData = getweathercity(cityName);
                        setState(() {
                          UpdateUi(widget.weatherdata);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.location_on,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                cityName ?? 'New York',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                tempIncel ?? '13 c',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${emoji}', style: TextStyle(fontSize: 35)),
                  Text(
                    currentWeather ?? '🌤️',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String kelvinTocel(var temp) {
    var tempincel = temp - 273.15;
    String tempstring = tempincel.floor().toString();
    return tempstring;
  }

  void getweathercity(String cityName) async {
    var cityWeatherApI =
        "https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}";
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': cityName,
      'appid': apiKey,
    });

    var response = await http.get(url);

    var data = response.body;
    var weatherData = jsonDecode(data);
    UpdateUi(weatherData);
  }

  void UpdateUi(weatherData) {
    var weatherid = weatherData['weather'][0]['id'];
    if (weatherid > 200 && weatherid < 300) {
      setState(() {
        emoji = "⛈️";
      });
    } else if (weatherid > 300 && weatherid < 400) {
      setState(() {
        emoji = "🌧️";
      });
    } else if (weatherid > 500 && weatherid < 600) {
      setState(() {
        emoji = "🌦️";
      });
    } else if (weatherid > 700 && weatherid < 800) {
      setState(() {
        emoji = "🧊";
      });
    } else if (weatherid >= 800) {
      setState(() {
        emoji = "🌤️";
      });
    }
    setState(() {
      var tamp = weatherData['main']['temp'];
      tempIncel = kelvinTocel(tamp);
      currentWeather = weatherData['weather'][0]['main'];
      cityName = weatherData['name'];
    });
  }
}
