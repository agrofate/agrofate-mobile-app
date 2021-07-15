import 'package:agrofate_mobile_app/services/forecast_by_hour.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/utilities/forecast_json.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_icons/weather_icons.dart';

class DetailForecastScreen extends StatefulWidget {
  const DetailForecastScreen({Key? key}) : super(key: key);

  @override
  _DetailForecastScreenState createState() => _DetailForecastScreenState();
}

class _DetailForecastScreenState extends State<DetailForecastScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TitleFormsWidget(
                        titleText: 'Previsão do tempo \ndetalhada',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DescriptionFormsWidget(
                    descriptionText:
                        'Entenda o melhor momento para a produção de acordo com as previsões em sua localização.',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    // todo: personalizar box de acordo com previsao no momento
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1.5,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText1,
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'Segunda',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ', 28/06',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Ipiranga, São Paulo",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  weather[2]['icon'],
                                  width: 80,
                                  height: 80,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text: '24.1º',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: kGreenColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '/14º',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 19,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          WeatherIcons.humidity,
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "5%",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          WeatherIcons.strong_wind,
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      "2 km/h",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: size.height * 0.4,
                    child: RawScrollbar(
                      thumbColor: kGreenColor,
                      thickness: 3,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: forecastByHour.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            // decoration: const BoxDecoration(color: Colors.black12),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: (size.width - 60) * 0.20,
                                      child: Text(
                                        forecastByHour[index].hour,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // decoration: const BoxDecoration(
                                      //     color: Colors.black12),
                                      width: (size.width - 60) * 0.14,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                WeatherIcons.thermometer,
                                                size: 14,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            forecastByHour[index].temperature,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: (size.width - 60) * 0.21,
                                      child: Row(
                                        children: [
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
                                            width: 6,
                                          ),
                                          Text(
                                            forecastByHour[index].windVelocity,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // decoration: const BoxDecoration(
                                      //     color: Colors.black12),
                                      width: (size.width - 60) * 0.15,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                WeatherIcons.rain,
                                                size: 14,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            forecastByHour[index].rainProbability,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: (size.width - 60) * 0.17,
                                      child: Row(
                                        children: [
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
                                            width: 5,
                                          ),
                                          Text(
                                            forecastByHour[index].humidity,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                const Divider(
                                  thickness: 0.8,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<ForecastByHour> forecastByHour = [
  ForecastByHour(
    hour: "13:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "14:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "15:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "16:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "17:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "18:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "19:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "20:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "21:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "22:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
  ForecastByHour(
    hour: "23:00",
    temperature: "20º",
    windVelocity: "2 km/h",
    rainProbability: "10%",
    humidity: "50%",
  ),
];
