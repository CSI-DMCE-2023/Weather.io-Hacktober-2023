// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/components/my_button.dart';
import 'package:weather_app/components/my_textfield.dart';
import 'package:weather_app/components/my_tile.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final citynameController = TextEditingController();
  final String API_KEY = 'b3257e61c452dcc761c19d2378555860';
  String city = "";
  String conditions = "";
  double temperature = 0.0;
  double feelsLike = 0.0;
  double tempMin = 0.0;
  double tempMax = 0.0;
  int humidity = 0;
  double windSpeed = 0.0;
  int windDeg = 0;
  bool resultFetched = false;

  void getWeatherData() async {
    String cityName = citynameController.text;
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$API_KEY'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final weatherData = Weather(
        cityName: data['name'],
        condition: data['weather'][0]['main'],
        temperature: data['main']['temp'],
        feelsLike: data['main']['feels_like'],
        tempMin: data['main']['temp_min'],
        tempMax: data['main']['temp_max'],
        humidity: data['main']['humidity'],
        windSpeed: data['wind']['speed'],
        windDeg: data['wind']['deg'],
      );
      setState(() {
        city = weatherData.cityName;
        conditions = weatherData.condition;
        temperature = weatherData.temperature;
        feelsLike = weatherData.feelsLike;
        tempMin = weatherData.tempMin;
        tempMax = weatherData.tempMax;
        humidity = weatherData.humidity;
        windSpeed = weatherData.windSpeed;
        windDeg = weatherData.windDeg;
        resultFetched = true;
      });
      print(weatherData.temperature);
    } else {
      AlertDialog(
        title: Column(children: [
          Icon(
            Icons.wrong_location,
            color: Colors.red,
            size: 25,
          ),
          Text(
            "Oops! No such city.",
            style: GoogleFonts.manrope(fontSize: 20, color: Colors.black),
          )
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[100],
          elevation: 0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.brown[100]),
          title: Text(
            "weather.io",
            style: GoogleFonts.manrope(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(controller: citynameController),
                        SizedBox(
                          height: 15,
                        ),
                        MyButton(onTap: getWeatherData)
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 234, 235),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: resultFetched
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$city",
                            style: GoogleFonts.manrope(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Temperature",
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "$temperature\u00B0C",
                                style: GoogleFonts.manrope(
                                  fontSize: 50,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Min $tempMin\u00B0C",
                                      style: GoogleFonts.manrope(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "Max $tempMax\u00B0C",
                                      style: GoogleFonts.manrope(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "$conditions",
                            style: GoogleFonts.manrope(
                                fontSize: 25, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              MyInfoTile(
                                title: 'Feels Like',
                                iconData: Icons.emoji_emotions,
                                value: '$feelsLike\u00B0C',
                              ),
                              MyInfoTile(
                                title: 'Humidity',
                                iconData: Icons.waves,
                                value: '$humidity',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              MyInfoTile(
                                title: 'Wind Speed',
                                iconData: Icons.wind_power,
                                value: '$windSpeed',
                              ),
                              MyInfoTile(
                                title: 'Wind Degree',
                                iconData: Icons.rotate_90_degrees_ccw,
                                value: '$windDeg',
                              ),
                            ],
                          )
                        ],
                      )
                    : Center(
                        child: Column(children: [
                          SizedBox(
                            height: 50,
                          ),
                          Icon(
                            Icons.sunny_snowing,
                            size: 150,
                            color: Colors.orange,
                          ),
                          Text(
                            "Check any city's weather conditions on fingertips!",
                            style: GoogleFonts.manrope(
                                fontSize: 20, color: Colors.black),
                          )
                        ]),
                      ),
              ),
            ),
          ],
        ));
  }
}
