import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/screens/detail_forecast_screen.dart';
import 'package:agrofate_mobile_app/screens/new_local_screen.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/utilities/forecast_json.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LanguageChangeProvider.dart';
import 'config_screen.dart';

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
  var cidade_local;
  var forecast_data;
  var teste_link;
  var hora_atual;
  var visibility_forecast=false;
  var adresses;
  var first;
  String _id_user;
  bool loading = true;

  _dataEscolhida(data_atual) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('data_escolhida', data_atual.toString());
      prefs.setString('nome_local', nome_local.toString());
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => new DetailForecastScreen(),
        /*settings: RouteSettings(
            arguments: new DateFormat('dd/MM').format(new DateTime.fromMillisecondsSinceEpoch(forecast_data["daily"][index]["dt"]*1000)).toString(),
          ),*/
      ),
    );
  }

  Future getWeather() async {
    //this.lat = '-23.5638291';
    //this.long = '-46.007628';
    this.codigo = '8508113bd018ec7a9708de6d57d2de9c';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_id_user == null){
      String parametros = "?email="+prefs.getString('email')+"&senha="+prefs.getString('senha');
      http.Response url_teste = await http.get(
          "https://future-snowfall-319523.uc.r.appspot.com/read-one"+parametros);
      var response_login1 = jsonDecode(url_teste.body)[0].asMap();
      print(response_login1);
      if(response_login1.length > 1){
        prefs.setString('id_user', response_login1[0].toString());
      }
    }
    _id_user = (prefs.getString('id_user'));
    String parametros = "?&id_usuario="+_id_user;
    http.Response latlng = await http.get(
          "https://future-snowfall-319523.uc.r.appspot.com/read-one-locais"+parametros);
    var response_latlng = json.decode(latlng.body);
    print("LatLong: ");
    print(response_latlng);

    if(response_latlng[0][0] == 0){
      setState(() {
        visibility_forecast=false;
        this.temp = 0;
        this.description = '';
        this.currently = '';
        this.humidity =  0;
        this.windSpeed =  0;
        this.nome_local =  '';
        this.cidade_local =  '';
        this.loading = false;
      });
    }else{
      visibility_forecast=true;
      http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=${response_latlng[(response_latlng.length-1)][2]}&lon=${response_latlng[(response_latlng.length-1)][3]}&lang=pt_br&units=metric&appid=${codigo}");
      var results = jsonDecode(response.body);

      /*http.Response forecast = await http.get(
          "https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${long}&lang=pt_br&units=metric&appid=${codigo}");
      forecast_data = jsonDecode(forecast.body);*/

      http.Response forecast = await http.get(
          "https://api.openweathermap.org/data/2.5/onecall?lat=${response_latlng[(response_latlng.length-1)][2]}&lon=${response_latlng[(response_latlng.length-1)][3]}&exclude={current,minutely,hourly,alerts}&appid=${codigo}&lang=pt_br&units=metric");
      forecast_data = jsonDecode(forecast.body);
      print(forecast_data);

      final coordinates = new Coordinates(response_latlng[(response_latlng.length-1)][2], response_latlng[(response_latlng.length-1)][3]);
      adresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      first = adresses.first;
      print("${first.featureName} : ${first.addressLine}");
      print(first.addressLine.split(',')[0]);

      setState(() {
        prefs.setString('latitude_escolhida', response_latlng[(response_latlng.length-1)][2].toString());
        prefs.setString('longitude_escolhida', response_latlng[(response_latlng.length-1)][3].toString());
        this.temp = results['main']['temp'];
        this.description = results['weather'][0]['description'];
        this.currently = results['weather'][0]['main'];
        this.humidity = results['main']['humidity'];
        this.windSpeed = results['wind']['speed'];
        this.nome_local = first.addressLine.split(',')[0];
        this.cidade_local = first.addressLine.split(',')[2];
        this.loading = false;
      });
    }   
    print(visibility_forecast);
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        title: Image.asset(
          "assets/logos/agrofate_logo_text.png",
          fit: BoxFit.cover,
          height: 25,
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
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfigScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(builder: (context, text) {
          if (loading) {
            return Container(
              height: size.height * 0.8,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } 
          else if(!visibility_forecast) {
            return Padding(
                  padding: const EdgeInsets.all(30),
                  child: ButtonWidget(
                    title: S.of(context).telaForecastBotaoNovoLocal,
                    hasBorder: true,
                    onClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewLocalScreen(),
                        ),
                      );
                    },
                  ),
                );
          }
          else {
            return Column(
              children: [
                Visibility(
                  visible: visibility_forecast,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
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
                            Center(
                              child: Text(
                              nome_local + ", " + cidade_local,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            )),
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
                        children: List.generate(forecast_data["daily"].length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // decoration: const BoxDecoration(color: Colors.black12),
                                      width: (size.width - 40),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                /*"assets/images/weather/" +
                                                    forecast_data["daily"]
                                                            [index]["weather"]
                                                        [0]["icon"] +
                                                    ".png",*/
                                                _setImage(forecast_data["daily"]
                                                            [index]["weather"]
                                                        [0]["icon"]),
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.045),
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
                                                  StringUtils.capitalize(DateFormat(
                                                          'EEEE', S.of(context).telaForecastDiadaSemana)
                                                      .format(DateTime.parse(new DateFormat(
                                                              'yyyy-MM-dd hh:mm:ss')
                                                          .format(new DateTime
                                                                  .fromMillisecondsSinceEpoch(
                                                              forecast_data["daily"]
                                                                          [index]
                                                                      ["dt"] *
                                                                  1000))))
                                                      .substring(0, 3)),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(new DateFormat('dd/MM')
                                                    .format(new DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                        forecast_data["daily"]
                                                                [index]["dt"] *
                                                            1000))),
                                                /*Text(
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
                                              ),*/
                                              ],
                                            ),
                                          ),
                                          Container(
                                            // decoration:
                                            //     const BoxDecoration(color: Colors.black38),
                                            width: (size.width) * 0.24,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: forecast_data["daily"]
                                                                            [
                                                                            index]
                                                                        ["temp"]
                                                                    ["max"]
                                                                .toStringAsFixed(0) +
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
                                                            forecast_data["daily"]
                                                                            [
                                                                            index]
                                                                        ["temp"]
                                                                    ["min"]
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
                                                      forecast_data["daily"]
                                                                      [index]
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
                                                          WeatherIcons
                                                              .strong_wind,
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
                                                      (forecast_data["daily"][
                                                                          index]
                                                                      [
                                                                      "wind_speed"] *
                                                                  3.6)
                                                              .toStringAsFixed(
                                                                  1) +
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
                                            width: (size.width) * 0.09,
                                            child: IconButton(
                                              onPressed: () {
                                                _dataEscolhida(new DateFormat(
                                                    'dd/MM')
                                                    .format(new DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                    forecast_data["daily"]
                                                    [index]
                                                    ["dt"] *
                                                        1000))
                                                    .toString());
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 18,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: (55 + (size.width * 0.045)), top: 6),
                                  child: Divider(
                                    thickness: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: ButtonWidget(
                    title: S.of(context).telaForecastBotaoNovoLocal,
                    hasBorder: true,
                    onClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewLocalScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
