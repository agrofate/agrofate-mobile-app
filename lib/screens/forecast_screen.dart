import 'package:agrofate_mobile_app/screens/detail_forecast_screen.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/utilities/forecast_json.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
    this.lat = '-23.5638291';
    this.long = '-46.007628';
    this.codigo = 'd34a8560ca9bb25f136577a590378db0';
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
    List<IconData> icon_weather = [
      Icons.wb_sunny,
      Icons.wb_cloudy,
      Icons.wb_incandescent
    ];
    final icon_weather_a = icon_weather.asMap();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            height: 0.8,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
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
                  const SnackBar(content: Text('Em desenvolvimento')));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              // TODO: ativar visualização qdo tiver local adicionado - se n tiver local, desativa a vis. e deixa só o botão
              visible: true,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 7,
                    width: MediaQuery.of(context).size.width * 0.9,
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
                          temp != null
                              ? temp.toStringAsFixed(1) + "\u00B0"
                              : "Carregando",
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
                    height: 10,
                  ),
                  Column(
                    // todo: limitar a 5 dias da semana
                    children:
                        List.generate(forecast_data["list"].length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // decoration: const BoxDecoration(color: Colors.black12),
                                  width: (size.width - 40),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            // todo: trocar icone/img de acordo com previsao
                                            weather[3]['icon_path'],
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Container(
                                        // decoration:
                                        //     const BoxDecoration(color: Colors.black26),
                                        width: (size.width) * 0.1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // todo: pegar 'seg' da API
                                              'Seg',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              forecast_data["list"][index]
                                                          ["dt_txt"]
                                                      .split(" ")[0]
                                                      .split("-")[2]
                                                      .toString() +
                                                  '/' +
                                                  forecast_data["list"][index]
                                                          ["dt_txt"]
                                                      .split(" ")[0]
                                                      .split("-")[1]
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // decoration:
                                        //     const BoxDecoration(color: Colors.black38),
                                        width: (size.width) * 0.26,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: forecast_data["list"]
                                                                        [index]
                                                                    ["main"]
                                                                ["temp_max"]
                                                            .toStringAsFixed(
                                                                1) +
                                                        'º',
                                                    style: TextStyle(
                                                      color: kGreenColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "/" +
                                                        forecast_data["list"]
                                                                        [index]
                                                                    ["main"]
                                                                ["temp_min"]
                                                            .toStringAsFixed(
                                                                0) +
                                                        'º',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // decoration:
                                        //     const BoxDecoration(color: Colors.black26),
                                        width: (size.width) * 0.24,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 9,
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(
                                                      WeatherIcons.raindrop,
                                                      size: 14,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  forecast_data["list"][index]
                                                                  ["main"]
                                                              ["humidity"]
                                                          .toString() +
                                                      '%',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 9,
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(
                                                      WeatherIcons.strong_wind,
                                                      size: 14,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  (forecast_data["list"][index]
                                                                      ["wind"]
                                                                  ["speed"] *
                                                              3.6)
                                                          .toStringAsFixed(1) +
                                                      ' km/h',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // decoration:
                                        //     const BoxDecoration(color: Colors.black38),
                                        width: (size.width) * 0.13,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                // todo: enviar para página de detalhes do dia selecionado
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailForecastScreen(),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 18,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 65, top: 6),
                              child: Divider(
                                thickness: 0.8,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    /*Container(
                child: Column(
                  children: List.generate(forecast_data["list"].length, (index) {
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            forecast_data["list"][index]["dt_txt"]
                                                    .split(" ")[0]
                                                    .split("-")[2]
                                                    .toString() +
                                                '/' +
                                                forecast_data["list"][index]
                                                        ["dt_txt"]
                                                    .split(" ")[0]
                                                    .split("-")[1]
                                                    .toString(),
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
                                        icon_weather_a[main_weather.indexWhere(
                                            (note) => note.startsWith(
                                                forecast_data["list"][index]
                                                        ["weather"][0]["main"]
                                                    .toString()))],
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
                                          style:
                                              DefaultTextStyle.of(context).style,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: forecast_data["list"][index]
                                                          ["main"]["temp_max"]
                                                      .toString() +
                                                  'º',
                                              style: TextStyle(
                                                color: Colors.deepOrangeAccent,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "/" +
                                                  forecast_data["list"][index]
                                                          ["main"]["temp_min"]
                                                      .toString() +
                                                  'º',
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
                                      decoration: const BoxDecoration(
                                          color: Colors.green),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                  Text(forecast_data["list"]
                                                                  [index]["main"]
                                                              ["humidity"]
                                                          .toString() +
                                                      '%'),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                  Text(forecast_data["list"]
                                                                  [index]["wind"]
                                                              ["speed"]
                                                          .toString() +
                                                      ' m/s'),
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
              ),*/
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: ButtonWidget(
                title: 'NOVO LOCAL',
                hasBorder: true,
                onClicked: () {
                  // todo: linkar nova tela de adc novo local
                  print("tela de adc novo local");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
