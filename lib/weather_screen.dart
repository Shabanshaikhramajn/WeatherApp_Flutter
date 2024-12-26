import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/hourly_forecarst.dart';
import 'package:weather_app/title.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double currentTemp = 0;
  String currentSkyCondition = '';
  bool isLoaded = true;
  int humidity = 0;

  bool status = false;

  String cityName = 'London';

  TextEditingController cc = TextEditingController();

  Future<void> getCurrentweather() async {
    try {
      String apiKey = 'c329a56a3b1c3b5e3d59eac140994e13';

      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=$apiKey'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          currentTemp = data['main']['temp'];
          currentTemp = ((currentTemp - 273.15) * 9 / 5) + 32;
          isLoaded = false;

          humidity = data['main']['humidity'];
          print(humidity);

          currentSkyCondition = data['weather'][0]['main'];
        });
      } else if (response.statusCode == 404) {
        setState(){
        status = true;

        }
        print('error ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cityName[0].toUpperCase() + cityName.substring(1),
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 40,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isLoaded = true;
                getCurrentweather();
              });

              print('refresh');
            },
          )
        ],
      ),
      body: status
          ?  Center(
              child: Text('City not found'),
            )
          : isLoaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Text(
                                  '${currentTemp.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  currentSkyCondition == 'Clouds'
                                      ? Icons.cloud
                                      : Icons.wb_sunny,
                                  size: 64,
                                  color: (currentSkyCondition == "Clouds"
                                      ? Colors.blueGrey
                                      : Colors.yellow[700]),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  '${currentSkyCondition}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(),
                        SizedBox(
                          height: 20,
                        ),
                        Shaban(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              HourlyForecastCard(humidity: humidity),
                              HourlyForecastCard(humidity: humidity),
                              HourlyForecastCard(humidity: humidity),
                              HourlyForecastCard(humidity: humidity),
                              HourlyForecastCard(humidity: humidity),
                              HourlyForecastCard(humidity: humidity),
                            ],
                          ),
                        ),
                        Shaban(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              HourlyForecastCard(humidity: humidity),
                              HourlyForecastCard(humidity: humidity),
                              HourlyForecastCard(humidity: humidity),
                              HourlyForecastCard(humidity: humidity),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("change location"),
                                        content: TextField(
                                          controller: cc,
                                          decoration: InputDecoration(
                                            hintText: "enter city name",
                                          ),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[a-zA-Z]'))
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  cityName = cc.text;
                                                  isLoaded = true;
                                                });
                                                getCurrentweather();
                                                Navigator.pop(context);
                                              },
                                              child: Text('ok')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel'))
                                        ],
                                      );
                                    });

                                // Navigator.pushNamed(context, '/search');
                              },
                              child: Text(
                                'Change City',
                                style: TextStyle(fontSize: 23),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
