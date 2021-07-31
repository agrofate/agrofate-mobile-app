import 'dart:convert';

import 'package:agrofate_mobile_app/screens/detail_canteiro_screen.dart';
import 'package:agrofate_mobile_app/services/canteiro.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'new_canteiro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CanteirosScreen extends StatefulWidget {
  const CanteirosScreen({Key? key}) : super(key: key);

  @override
  _CanteirosScreenState createState() => _CanteirosScreenState();
}

class _CanteirosScreenState extends State<CanteirosScreen> {
  String _email = '';
  String _id_user = '';
  String _id_canteiro_escolhido = '';
  var canteiro_data;
  bool loading = true;
  bool loading_canteiro = true;

  @override
  void initState() {
    _leContador();
    super.initState();
  }

  Future _leContador() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id_user = (prefs.getString('id_user') ?? '');
      _email = (prefs.getString('email') ?? '');
    });
    print(_email);
    print(_id_user);

    String parametros = "?id_usuario=" + _id_user;
    http.Response url_teste = await http.get(
        "https://future-snowfall-319523.uc.r.appspot.com/read-one-canteiro" +
            parametros);
    var response_login = jsonDecode(url_teste.body).asMap();
    canteiro_data = response_login;
    print(response_login);

    if (response_login.length > 0) {
      if (response_login[0][0] != 0){
        setState(() {
          loading_canteiro = false;
        });
      }
    }

    setState(() {
      this.loading = false;
    });
  }

  _canteiroEscolhido(id_canteiro, nome_canteiro) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('id_canteiro_escolhido', id_canteiro.toString());
      prefs.setString('nome_canteiro_escolhido', nome_canteiro.toString());
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailCanteiroScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
          'Seus canteiros',
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder(builder: (context, text) {
          if (loading) {
            return Container(
              height: size.height * 0.8,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (loading_canteiro) {
              return Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: ButtonWidget(
                    title: 'NOVO CANTEIRO',
                    hasBorder: true,
                    onClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewCanteiroScreen(),
                        ),
                      );
                    },
                  ),
                )
              ]);
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: canteiro_data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                // TODO: enviar para página de detalhes do canteiro selecionado
                                _canteiroEscolhido(canteiro_data[index][0],
                                    canteiro_data[index][2]);
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailCanteiroScreen(),
                                  ),
                                );*/
                              },
                              child: Container(
                                // decoration:
                                //     const BoxDecoration(color: Colors.black12),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              // todo: trocar img do canteiro de acordo com banco - se tiver
                                              image: AssetImage(
                                                  "assets/images/canteiro_padrao.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              canteiro_data[index][2],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                              "Criação: " +
                                                  //canteiro_data[index][4],
                                                  canteiro_data[index][4]
                                                      .split(" ")[1] +
                                                  "/" +
                                                  canteiro_data[index][4]
                                                      .split(" ")[2] +
                                                  "/" +
                                                  canteiro_data[index][4]
                                                      .split(" ")[3],
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                              "Última atualização: " +
                                                  //canteiro_data[index][5],
                                                  canteiro_data[index][5]
                                                      .split(" ")[1] +
                                                  "/" +
                                                  canteiro_data[index][5]
                                                      .split(" ")[2] +
                                                  "/" +
                                                  canteiro_data[index][5]
                                                      .split(" ")[3],
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 75, top: 6),
                                      child: Divider(
                                        thickness: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                          title: 'NOVO CANTEIRO',
                          hasBorder: true,
                          onClicked: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewCanteiroScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
        }),
      ),
    );
  }
}

List<Canteiro> canteiros = [
  Canteiro(
    nomeCanteiro: "Canteiro Sul",
    dataCriacao: "26/06/21",
    dataUltimaAtualizacao: "27/06/21",
  ),
  Canteiro(
    nomeCanteiro: "Canteiro Norte",
    dataCriacao: "26/06/21",
    dataUltimaAtualizacao: "27/06/21",
  ),
  Canteiro(
    nomeCanteiro: "Canteiro Sul",
    dataCriacao: "26/06/21",
    dataUltimaAtualizacao: "27/06/21",
  ),
  Canteiro(
    nomeCanteiro: "Canteiro Norte",
    dataCriacao: "26/06/21",
    dataUltimaAtualizacao: "27/06/21",
  ),
];
