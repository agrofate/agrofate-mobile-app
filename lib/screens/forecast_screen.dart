import 'package:agrofate_mobile_app/utilities/enums.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_icons/weather_icons.dart';

class ForecastScreen extends StatefulWidget {
  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var lat;
  var long;
  var codigo;
  var nome_local;
  var forecast_data;

  Future getWeather() async {
    this.lat = '';
    this.long = '';
    this.codigo = '';
    http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&lang=pt_br&units=metric&appid=${codigo}");
    var results = jsonDecode(response.body);

    http.Response forecast = await http.get(
        "https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${long}&lang=pt_br&units=metric&appid=${codigo}");
    forecast_data = jsonDecode(forecast.body);

    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.nome_local = results['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List main_weather = ["Clear", "Clouds", "Rain"];
    final main_weather_a = main_weather.asMap();
    List<IconData> icon_weather = [Icons.wb_sunny, Icons.wb_cloudy, Icons.wb_incandescent];
    final icon_weather_a = icon_weather.asMap();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'agrofate',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Isso é um SnackBar')));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // todo: trocar icon de acordo com dia/noite
                  // ignore: prefer_const_constructors
                  Icon(
                    Icons.wb_sunny,
                    size: 32,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    nome_local + ", São Paulo",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    temp != null ? temp.toString() + "\u00B0" : "Carregando",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            /*Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (size.width) * 0.9,
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              width: (size.width) * 0.15,
                              // decoration: const BoxDecoration(color: Colors.grey),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Seg',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    '28/06',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: (size.width) * 0.15,
                              // decoration:
                              //     const BoxDecoration(color: Colors.green),
                              // todo: colocar imagem aqui de acordo com API
                              child: Icon(
                                Icons.wb_cloudy,
                                size: 42,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: (size.width) * 0.25,
                              // decoration:
                              //     const BoxDecoration(color: Colors.green),
                              // todo: inserir infos da API
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '24º',
                                      style: TextStyle(
                                        color: Colors.deepOrangeAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "/" + "14º",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: (size.width) * 0.15,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        WeatherIcons.rain,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("10%"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        WeatherIcons.rain,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("10%"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: (size.width) * 0.15,
                              // decoration:
                              //     const BoxDecoration(color: Colors.green),
                              child: Icon(Icons.arrow_forward_ios),
                            ),                                                    
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),*/
            Container(
              child: Column(
                children: List.generate(forecast_data["list"].length,(index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: (size.width) * 0.9,
                              height: 50,
                              child: Row(
                                children: [
                                  Container(
                                    width: (size.width) * 0.15,
                                    // decoration: const BoxDecoration(color: Colors.grey),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Seg',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          forecast_data["list"][index]["dt_txt"].split(" ")[0].split("-")[2].toString()+'/'+forecast_data["list"][index]["dt_txt"].split(" ")[0].split("-")[1].toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: (size.width) * 0.15,
                                    // decoration:
                                    //     const BoxDecoration(color: Colors.green),
                                    // todo: colocar imagem aqui de acordo com API
                                    child: Icon(                         
                                      icon_weather_a[main_weather.indexWhere((note) => note.startsWith(forecast_data["list"][index]["weather"][0]["main"].toString()))],
                                      //icon_weather_a[int.parse(main_weather.indexOf(forecast_data["list"][index]["weather"][0]["main"]))],
                                      size: 42,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: (size.width) * 0.25,
                                    // decoration:
                                    //     const BoxDecoration(color: Colors.green),
                                    // todo: inserir infos da API
                                    child: RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: forecast_data["list"][index]["main"]["temp_max"].toString() + 'º',
                                            style: TextStyle(
                                              color: Colors.deepOrangeAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "/" + forecast_data["list"][index]["main"]["temp_min"].toString() + 'º',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: (size.width) * 0.15,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              WeatherIcons.humidity,
                                              size: 15,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(forecast_data["list"][index]["main"]["humidity"].toString() + '%'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              WeatherIcons.strong_wind,
                                              size: 15,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(forecast_data["list"][index]["wind"]["speed"].toString() + ' m/s'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: (size.width) * 0.15,
                                    // decoration:
                                    //     const BoxDecoration(color: Colors.green),
                                    child: Icon(Icons.arrow_forward_ios),
                                  ),                                                    
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );                
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
