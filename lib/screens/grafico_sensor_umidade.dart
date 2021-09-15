import 'dart:convert';
import 'dart:math';

import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/screens/dados_screen.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../LanguageChangeProvider.dart';

class GraficoSensorUmidade extends StatefulWidget {
  const GraficoSensorUmidade({Key key}) : super(key: key);

  @override
  _GraficoSensorUmidadeState createState() => _GraficoSensorUmidadeState();
}

class SensorPH {
  String data;
  double ph;
  SensorPH(this.data, this.ph);
}

class _GraficoSensorUmidadeState extends State<GraficoSensorUmidade> {
  List<SensorPH> _data;
  List<charts.Series<SensorPH, String>> _chartdata;
  bool loading = false;
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  Future<void> _makeData() async {
    _data = new List<SensorPH>();
    _chartdata = new List<charts.Series<SensorPH, String>>();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String parametros = "?id_sensor="+prefs.getString('id_sensor');
    http.Response url_teste = await http.get(
        "https://future-snowfall-319523.uc.r.appspot.com/read-one-media-ph-historico-sensor"+parametros);
    var response_login1 = jsonDecode(url_teste.body).asMap();

    for(int i = 0; i < response_login1.length; i++){      
      var a =response_login1[i][0].split(" ")[1]+"/"+(months.indexOf(response_login1[i][0].split(" ")[2])+1).toString();
      _data.add(new SensorPH(a.toString(), response_login1[i][1]));
      /*print(a);
      print(response_login1[i][2]);*/
    }

    /*final rnd = new Random();
    for(int i = 2010; i < 2019; i++){
      _data.add(new SensorPH(i.toString(), rnd.nextDouble()));
    }*/    

    try {
      if (url_teste.statusCode == 200) {
        print("ok");
        setState(() {
          this.loading = true;
        });
        _chartdata.add(new charts.Series(
          id: 'Sensor Umidade', 
          colorFn: (_,__) => charts.MaterialPalette.green.shadeDefault,
          data: _data, 
          domainFn: (SensorPH sensorPh, _) => sensorPh.data, 
          measureFn: (SensorPH sensorPh, _) => sensorPh.ph,
          fillPatternFn: (_,__) => charts.FillPatternType.solid,
          displayName: 'Umidade'
          )
        );
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }

  @override
  void initState() {
    _makeData();
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new DadosScreen(),
            ),
          ),
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
      body: new Container(
        
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text('Sensor Umidade'),
              if(loading) new Expanded(child: new charts.BarChart(_chartdata)),
            ],
          ),
        ),
      ),
    );
  }
}