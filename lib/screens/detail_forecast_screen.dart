import 'dart:convert';

import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/services/forecast_by_hour.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/utilities/forecast_json.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

import '../LanguageChangeProvider.dart';

class DetailForecastScreen extends StatefulWidget {
  const DetailForecastScreen({Key key}) : super(key: key);

  @override
  _DetailForecastScreenState createState() => _DetailForecastScreenState();
}

class _DetailForecastScreenState extends State<DetailForecastScreen> {
  var lat;
  var long;
  var codigo;
  var dia_total;
  var dia_escolhido;
  var temp_min, temp_max, humidity, wind, icon, data_completa;
  var add_dia = [];
  var data_escolhida;
  var nome_local;
  var hora_atual;
  var latitude_escolhida;
  var longitude_escolhida;
  var indice_escolhido;
  bool loading = true;

  Future getWeatherHourly(data_atual) async {
    this.lat = '-23.5638291';
    this.long = '-46.007628';
    this.codigo = '8508113bd018ec7a9708de6d57d2de9c';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      latitude_escolhida = (prefs.getString('latitude_escolhida') ?? '');
      longitude_escolhida = (prefs.getString('longitude_escolhida') ?? '');
      indice_escolhido = (prefs.getString('indice_local') ?? '');
    });

    var dia = [];
    var dia_espec = [];

    if(int.parse(indice_escolhido) <= 2 || int.parse(indice_escolhido) > 4){
      http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/onecall?lat=${latitude_escolhida}&lon=${longitude_escolhida}&exclude={current,minutely,alerts}&appid=${codigo}&lang=pt_br&units=metric");
      var results = jsonDecode(response.body);
      
      print(data_atual);
      for (var i = 0; i < results["hourly"].length; i++) {
        //print(data_atual);
        //print(DateFormat('dd/MM').format(new DateTime.fromMillisecondsSinceEpoch(results["hourly"][i]["dt"]*1000)).toString());
        if (DateFormat('dd/MM')
                .format(new DateTime.fromMillisecondsSinceEpoch(
                    results["hourly"][i]["dt"] * 1000))
                .toString() ==
            data_atual) {
          dia.add(results["hourly"][i]);
        }
      }

      for (var i = 0; i < results["daily"].length; i++) {
        //print(data_atual);
        //print(DateFormat('dd/MM').format(new DateTime.fromMillisecondsSinceEpoch(results["hourly"][i]["dt"]*1000)).toString());
        if (DateFormat('dd/MM')
                .format(new DateTime.fromMillisecondsSinceEpoch(
                    results["daily"][i]["dt"] * 1000))
                .toString() ==
            data_atual) {
          add_dia.add(results["daily"][i]["temp"]["min"].toStringAsFixed(0));
          add_dia.add(results["daily"][i]["temp"]["max"].toStringAsFixed(0));
          add_dia.add(results["daily"][i]["humidity"].toString());
          add_dia.add(results["daily"][i]["wind_speed"].toStringAsFixed(1));
          add_dia.add(results["daily"][i]["weather"][0]["icon"].toString());
          add_dia.add(results["daily"][i]["dt"]);
        }
      }
    }else{
      http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/forecast?lat=${latitude_escolhida}&lon=${longitude_escolhida}&exclude={current,minutely,alerts}&appid=${codigo}&lang=pt_br&units=metric");
      var results = jsonDecode(response.body);

      print(data_atual);
      for (var i = 0; i < results["list"].length; i++) {
        //print(data_atual);
        //print(DateFormat('dd/MM').format(new DateTime.fromMillisecondsSinceEpoch(results["hourly"][i]["dt"]*1000)).toString());
        if (DateFormat('dd/MM')
                .format(new DateTime.fromMillisecondsSinceEpoch(
                    results["list"][i]["dt"] * 1000))
                .toString() ==
            data_atual) {
          results["list"][i]["temp"] = results["list"][i]["main"]["temp"];
          results["list"][i]["clouds"] = results["list"][i]["clouds"]["all"];
          results["list"][i]["wind_speed"] = results["list"][i]["wind"]["speed"];
          results["list"][i]["humidity"] = results["list"][i]["main"]["humidity"];
          dia.add(results["list"][i]);
        }
      }

      for (var i = 0; i < results["list"].length; i++) {
        //print(data_atual);
        //print(DateFormat('dd/MM').format(new DateTime.fromMillisecondsSinceEpoch(results["hourly"][i]["dt"]*1000)).toString());
        if (DateFormat('dd/MM')
                .format(new DateTime.fromMillisecondsSinceEpoch(
                    results["list"][i]["dt"] * 1000))
                .toString() ==
            data_atual) {
          add_dia.add(results["list"][i]["main"]["temp_min"].toStringAsFixed(0));
          add_dia.add(results["list"][i]["main"]["temp_max"].toStringAsFixed(0));
          add_dia.add(results["list"][i]["main"]["humidity"].toString());
          add_dia.add(results["list"][i]["wind"]["speed"].toStringAsFixed(1));
          add_dia.add(results["list"][i]["weather"][0]["icon"].toString());
          add_dia.add(results["list"][i]["dt"]);
        }
      }
    }

    print(dia.length);
    print(add_dia);
    print(dia);

    setState(() {
      this.dia_total = dia;
      this.dia_escolhido = data_atual;
      this.loading = false;
      this.temp_min = add_dia[0];
      this.temp_max = add_dia[1];
      this.humidity = add_dia[2];
      this.wind = add_dia[3];
      this.icon = add_dia[4];
      this.data_completa = add_dia[5];
    });
  }

  @override
  void initState() {
    super.initState();
    _procuraData();
  }

  

  Future _procuraData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      data_escolhida = (prefs.getString('data_escolhida') ?? '');
      nome_local = (prefs.getString('nome_local') ?? '');
    });
    print(data_escolhida);
    this.getWeatherHourly(data_escolhida);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final task = ModalRoute.of(context)?.settings.arguments;
    //final String agora  = '${task}';

    void _changeLanguage(Language language) async {
      //Locale _locale = await setLocale(language.languageCode);
      print(language.languageCode);
      setState(() {
        context.read<LanguageChangeProvider>().changeLocale(language.languageCode);      
      });
      //MyHomePage.setLocale(context, _locale);
    }

    hora_atual = DateFormat('kk:mm:ss').format(DateTime.now()).toString().split(':')[0];
    print(DateFormat('kk:mm:ss').format(DateTime.now()).toString().split(':')[0]);

    String _setImage(imagem) {
      if(int.parse(hora_atual) > 6 && int.parse(hora_atual) < 18) {
        return "assets/images/weather/" + imagem +".png";
      } else {
        return "assets/images/weather/" + imagem.toString().substring(0,2)+"n.png";
      } 
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Language>(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                onChanged: (Language language) {
                  _changeLanguage(language);
                },
                items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
              ),
          ),
        ],
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
                        titleText: S.of(context).telaDetalheForecastTitulo,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DescriptionFormsWidget(
                    descriptionText:
                    S.of(context).telaDetalheForecastDescricao,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(builder: (context, text) {
                    if (loading) {
                      return CircularProgressIndicator();
                    } else {
                      return Column(
                        children: [
                          Container(
                            // height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width * 0.9,
                            // todo: personalizar box de acordo com previsao no momento
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyText1,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: StringUtils.capitalize(DateFormat(
                                            'EEEE', S.of(context).telaForecastDiadaSemana)
                                            .format(DateTime.parse(new DateFormat(
                                            'yyyy-MM-dd hh:mm:ss')
                                            .format(new DateTime
                                            .fromMillisecondsSinceEpoch(
                                            this.data_completa * 1000))))),
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: ", " + this.dia_escolhido,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  nome_local+", São Paulo",
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
                                          //weather[2]['icon_path'],
                                          /*"assets/images/weather/" +
                                              this.icon +
                                              ".png",*/
                                          _setImage(this.icon),
                                          width: 78,
                                          height: 78,
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            children: <TextSpan>[
                                              TextSpan(
                                                //text: '24.1º',
                                                text: '' + this.temp_max + 'º',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: kGreenColor,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '/' + this.temp_min + 'º',
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
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  WeatherIcons.raindrop,
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
                                              this.humidity + "%",
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
                                              this.wind + " km/h",
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
                                SizedBox(
                                  height: size.height * 0.03,
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
                                itemCount: dia_total.length,
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
                                              width: (size.width - 60) * 0.18,
                                              child: Text(
                                                //forecastByHour[index].hour,
                                                new DateFormat('HH:mm')
                                                    .format(new DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                    dia_total[index]["dt"] *
                                                        1000))
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // decoration: const BoxDecoration(
                                              //     color: Colors.black12),
                                              width: (size.width - 60) * 0.13,
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
                                                    //forecastByHour[index].temperature,
                                                    dia_total[index]["temp"]
                                                        .toStringAsFixed(0) +
                                                        'º',
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: (size.width - 60) * 0.23,
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
                                                    //forecastByHour[index].windVelocity,
                                                    dia_total[index]["wind_speed"]
                                                        .toStringAsFixed(1) +
                                                        ' km/h',
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
                                              width: (size.width - 60) * 0.17,
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
                                                    //forecastByHour[index].rainProbability,
                                                    dia_total[index]["clouds"]
                                                        .toString() +
                                                        " %",
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: (size.width - 60) * 0.16,
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
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    //forecastByHour[index].humidity,
                                                    dia_total[index]["humidity"]
                                                        .toString() +
                                                        ' %',
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
                      );
                    }
                  }),
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
