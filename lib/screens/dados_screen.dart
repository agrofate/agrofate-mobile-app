import 'dart:convert';

import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/notification_dados_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DadosScreen extends StatefulWidget {
  const DadosScreen({Key? key}) : super(key: key);

  @override
  _DadosScreenState createState() => _DadosScreenState();
}

class _DadosScreenState extends State<DadosScreen> {
  String _id_user = '';
  var loading_dados = true;
  var sensor_umidade;
  var sensor_ph;
  var data_ultima;

  Future _procuraSensor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id_user = (prefs.getString('id_user') ?? '');
    });
    print(_id_user);

    String parametros = "?id_usuario=" + _id_user;
    http.Response url_teste = await http.get(
        "https://future-snowfall-319523.uc.r.appspot.com/read-one-historico-sensor" +
            parametros);
    var response_login = jsonDecode(url_teste.body).asMap();
    print(response_login[0]);
    if (response_login.length > 0) {
      if (response_login[0][0] == 0) {
        loading_dados = true;
      } else {
        loading_dados = false;
        prefs.setString('id_sensor', response_login[0][0].toString());
        setState(() {
          sensor_umidade = response_login[0][1];
          sensor_ph = response_login[0][2];
          data_ultima = response_login[0][3];
        });
        print(data_ultima);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _procuraSensor();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          'Dados',
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
        child: FutureBuilder(builder: (context, text) {
          if (loading_dados) {
            return Container(
              height: size.height * 0.8,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Visibility(
                    // TODO: personalizar notifications de acordo com informações do BD
                    visible: true,
                    child: NotificationDadosWidget(
                      message:
                          "O nível de pH está fora do intervalo certo. \nÉ indicado acrescentar mais fertilizante.",
                      // vermelho
                      colorNotification: 0xFFF44336,
                      iconNotification: Icons.warning,

                      // verde
                      // colorNotification: 0xff4b9100,
                      // iconNotification: Icons.check_outlined,

                      // azul
                      // colorNotification: 0xFF2196F3,
                      // iconNotification: Icons.info,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/water-drop.png",
                                    width:
                                        MediaQuery.of(context).size.height / 8,
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    sensor_umidade + "%",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Umidade do solo",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "Importante para a formação",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "adequada das plantas",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: boxPhColor(sensor_ph),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/ph-meter_1.png",
                                    width:
                                        MediaQuery.of(context).size.height / 8,
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    sensor_ph,
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Acidez do solo - pH",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    // TODO: recuperar status do pH do solo do BD
                                    "Status: " + "Alcalino",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "Indicador de fertilidade",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  // Text(
                                  //   "Faixa de pH ideal: 5,5 e 6,5",
                                  //   style: TextStyle(
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Última atualização: " +
                            data_ultima.split(" ")[1]+"/"+data_ultima.split(" ")[2]+"/"+data_ultima.split(" ")[3]+
                            //"22/07/2021" +
                            " às " +                          
                            data_ultima.split(" ")[4],
                            //"18:00",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    title: 'NOVO EQUIPAMENTO',
                    hasBorder: true,
                    onClicked: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Em desenvolvimento')));
                    },
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

boxPhColor(sensor_ph) {
  var valorPh = double.parse(sensor_ph);

  if (valorPh > 0 && valorPh < 4) {
    return Color(0xFFF44336).withOpacity(0.1);
  } else if (valorPh >= 4 && valorPh < 5) {
    return Color(0xFFFF9800).withOpacity(0.1);
  } else if (valorPh >= 5 && valorPh < 7) {
    return Color(0xFFfce653).withOpacity(0.1);
  } else if (valorPh >= 7 && valorPh < 8) {
    return Color(0xFFa0c96d).withOpacity(0.1);
  } else if (valorPh >= 8 && valorPh < 10) {
    return Color(0xFF3ba47d).withOpacity(0.1);
  } else if (valorPh >= 10 && valorPh < 11) {
    return Color(0xFF0f6985).withOpacity(0.1);
  } else if (valorPh >= 11 && valorPh <= 14) {
    return Color(0xFF251d53).withOpacity(0.1);
  } else {
    return Color(0xFF9E9E9E).withOpacity(0.1);
  }

  // cinza padrao
  // color: Color(0xFF9E9E9E).withOpacity(0.1),

  // muito ácido 1-3
  // color: Color(0xFFF44336).withOpacity(0.1),

  // ácido 4
  // color: Color(0xFFFF9800).withOpacity(0.1),

  // levemente ácido 5-6
  // color: Color(0xFFfce653).withOpacity(0.1),

  // neutro 7
  // color: Color(0xFFa0c96d).withOpacity(0.1),

  // levemente alcalino 8-9
  // color: Color(0xFF3ba47d).withOpacity(0.1),

  // alcalino 10
  // color: Color(0xFF0f6985).withOpacity(0.1),

  // muito alcalino 11-14
  // color: Color(0xFF251d53).withOpacity(0.1),
}
