import 'dart:convert';

import 'package:agrofate_mobile_app/screens/edit_canteiro_screen.dart';
import 'package:agrofate_mobile_app/screens/edit_defensivo_screen.dart';
import 'package:agrofate_mobile_app/screens/edit_fertilizante_screen.dart';
import 'package:agrofate_mobile_app/screens/history_safra_screen.dart';
import 'package:agrofate_mobile_app/screens/new_defensivo_screen.dart';
import 'package:agrofate_mobile_app/screens/new_fertilizante_screen.dart';
import 'package:agrofate_mobile_app/screens/new_safra_screen.dart';
import 'package:agrofate_mobile_app/services/defensivo.dart';
import 'package:agrofate_mobile_app/services/fertilizante.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailCanteiroScreen extends StatefulWidget {
  const DetailCanteiroScreen({Key? key}) : super(key: key);

  @override
  _DetailCanteiroScreenState createState() => _DetailCanteiroScreenState();
}

class _DetailCanteiroScreenState extends State<DetailCanteiroScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _id_canteiro_escolhido = '';
  String _nome_canteiro_escolhido = '';
  bool loading = true;
  bool loading_safra = true;
  bool loading_safra_detalhe = true;
  bool loading_fertilizante = true;
  bool loading_fertilizante_detalhe = true;
  var safra_data;
  var nome_canteiro;
  var nome_safra;
  var data_plantacao;
  var nome_cultura;
  var fert_data;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _procuraSafra();
  }

  Future _procuraSafra() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id_canteiro_escolhido = (prefs.getString('id_canteiro_escolhido') ?? '');
      _nome_canteiro_escolhido =
          (prefs.getString('nome_canteiro_escolhido') ?? '');
    });
    print(_id_canteiro_escolhido);
    print(_nome_canteiro_escolhido);

    String parametros = "?id_canteiro=" + _id_canteiro_escolhido;
    http.Response url_teste = await http.get(
        "https://future-snowfall-319523.uc.r.appspot.com/read-one-safra" +
            parametros);
    var response_login = jsonDecode(url_teste.body).asMap();
    safra_data = response_login;
    print(response_login);
    print(response_login.length);

    if (response_login.length > 0) {
      if (response_login[0][0] == 0) {
        setState(() {
          this.loading = false;
          this.loading_safra = true;
          this.loading_safra_detalhe = false;
        });
        print(this.loading);
        print(this.loading_safra);
        print(this.loading_safra_detalhe);
      } else {
        prefs.setString('id_safra_atual', response_login[0][0].toString());
        print(response_login[0][0].toString());
        this.loading = false;
        this.loading_safra = false;
        loading_safra_detalhe = true;
        setState(() {
          this.loading = false;
          this.loading_safra = false;
          this.loading_safra_detalhe = true;
          this.nome_safra = response_login[0][2];
          this.data_plantacao = response_login[0][3];
          this.nome_cultura = response_login[0][5];
        });

        String parametros_fert = "?id_safra=" + response_login[0][0].toString();
        print(parametros_fert);
        http.Response url_teste_fert = await http.get(
            "https://future-snowfall-319523.uc.r.appspot.com/read-one-fertilizante" +
                parametros_fert);
        var response_login_fert = jsonDecode(url_teste_fert.body).asMap();
        print("Linha 95: ");
        print(response_login_fert.length);
        if (response_login_fert.length > 0) {
          print(response_login_fert[0][0]);
          if (response_login_fert[0][0] == 0) {
            setState(() {
              this.loading_fertilizante = false;
              this.loading_fertilizante_detalhe = false;
            });
          } else {
            setState(() {
              fert_data = response_login_fert;
              this.loading_fertilizante = false;
              this.loading_fertilizante_detalhe = true;
            });
          }
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              // TODO: enviar com informações do canteiro para editar
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCanteiroScreen(),
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
          } else {
            return Column(
              children: [
                Container(
                  width: size.width,
                  // TODO: se tiver safra altura menor - se nao tiver safra altura maior / recuperar do BD
                  height: true ? (size.height) * 0.23 : (size.height) * 0.33,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/canteiro_padrao.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: -15.0,
                          offset: Offset(0, -15),
                          blurRadius: 40.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                _nome_canteiro_escolhido,
                                // TODO: nome do canteiro
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  //TODO: adicionar lógica de safra ativa ou inativa para exibir botão de nova safra e histórico
                  visible: loading_safra,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Adicione uma nova safra",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonWidget(
                          title: 'NOVA SAFRA',
                          hasBorder: false,
                          onClicked: () {
                            // TODO: enviar informação de qual canteiro terá uma nova safra
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewSafraScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonWidget(
                          title: 'HISTÓRICO DE SAFRAS',
                          hasBorder: true,
                          onClicked:
                              false //TODO: recuperar informação se existe histórico de safras
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HistorySafraScreen(),
                                        ),
                                      );
                                    }
                                  : () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Não existe histórico de safras! Crie uma nova safra.')));
                                    },
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    //TODO: adicionar lógica de safra ativa para exibir fertilizantes e defensivos
                    visible: loading_safra_detalhe,
                    child: FutureBuilder(builder: (context, text) {
                      if (!loading_safra_detalhe) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    nome_safra,
                                    // TODO: recuperar nome da safra do BD
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HistorySafraScreen(),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.history_outlined),
                                    iconSize: 21,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Data de plantação: " + data_plantacao,
                                    // TODO: recuperar data de plantação da safra do BD
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Última atualização: " + "27/06/21",
                                    // TODO: recuperar data de última atualização da safra do BD
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cultura: " + nome_cultura,
                                    // TODO: recuperar cultura da safra ativa do BD
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              Column(
                                children: [
                                  // give the tab bar a height [can change hheight to preferred height]
                                  Container(
                                    height: 35,
                                    // height: 45,
                                    // decoration: BoxDecoration(
                                    //   color: Colors.grey.withOpacity(0.1),
                                    //   borderRadius: BorderRadius.circular(
                                    //     10.0,
                                    //   ),
                                    // ),
                                    child: TabBar(
                                      controller: _tabController,
                                      // give the indicator a decoration (color and border radius)
                                      // indicator: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(
                                      //     10.0,
                                      //   ),
                                      //   color: kGreenColor,
                                      // ),
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.black,
                                      tabs: [
                                        // first tab [you can add an icon using the icon property]
                                        Tab(
                                          text: 'Fertilizantes',
                                        ),

                                        // second tab [you can add an icon using the icon property]
                                        Tab(
                                          text: 'Defensivos',
                                        ),
                                      ],
                                    ),
                                  ),
                                  // tab bar view here
                                  Container(
                                    height: size.height * 0.42,
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        // first tab bar view widget
                                        //buildFertilizanteList(),
                                        FutureBuilder(builder: (context, text) {
                                          if (loading_fertilizante) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            if (!loading_fertilizante_detalhe) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: ButtonWidget(
                                                  title: 'NOVO FERTILIZANTE',
                                                  hasBorder: true,
                                                  onClicked: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewFertilizanteScreen(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            } else {
                                              return Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        (size.height * 0.42) -
                                                            70,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      padding: EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                      itemCount:
                                                          fert_data.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Container(
                                                          // decoration: const BoxDecoration(color: Colors.black12),
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: (size.width -
                                                                            60) *
                                                                        0.7,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          fert_data[index]
                                                                              [
                                                                              2],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              1,
                                                                        ),
                                                                        Text(
                                                                          "Marca: " +
                                                                              fert_data[index][3],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              1,
                                                                        ),
                                                                        Text(
                                                                          "Data de aplicação: " +
                                                                              fert_data[index][4],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Center(
                                                                    child:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                EditFertilizanteScreen(),
                                                                          ),
                                                                        );
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .edit_outlined),
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
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    child: ButtonWidget(
                                                      title:
                                                          'NOVO FERTILIZANTE',
                                                      hasBorder: true,
                                                      onClicked: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                NewFertilizanteScreen(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          }
                                        }),
                                        // second tab bar view widget
                                        buildDefensivoList(size),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: ButtonWidget(
                                  title: 'FINALIZAR SAFRA',
                                  hasBorder: false,
                                  onClicked: () {
                                    // todo: finalizar safra botao
                                    print("finalizar safra botao");
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    })),
              ],
            );
          }
        }),
      ),
    );
  }

  buildFertilizanteList() async {
    FutureBuilder(builder: (context, text) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ButtonWidget(
          title: 'NOVO FERTILIZANTE',
          hasBorder: true,
          onClicked: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewFertilizanteScreen(),
              ),
            );
          },
        ),
      );
      /*if (loading_fertilizante_detalhe) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container();*/
      /*if (loading_fertilizante_detalhe) {
            return Container();
          }else{
            return Column(
              children: [
                Container(
                  height: (size.height * 0.42) - 70,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                    itemCount: fertilizantes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // decoration: const BoxDecoration(color: Colors.black12),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (size.width - 60) * 0.7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fertilizantes[index].nome,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      Text(
                                        "Marca: " + fertilizantes[index].marca,
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      Text(
                                        "Data de aplicação: " +
                                            fertilizantes[index].dataAplicacao,
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditFertilizanteScreen(),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit_outlined),
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
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ButtonWidget(
                    title: 'NOVO FERTILIZANTE',
                    hasBorder: true,
                    onClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewFertilizanteScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }*/
      //}
    });
  }

  buildDefensivoList(Size size) {
    return Column(
      children: [
        Container(
          height: (size.height * 0.42) - 70,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            itemCount: defensivos.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // decoration: const BoxDecoration(color: Colors.black12),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: (size.width - 60) * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                defensivos[index].nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                "Marca: " + defensivos[index].marca,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                "Data de aplicação: " +
                                    defensivos[index].dataAplicacao,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditDefensivoScreen(),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit_outlined),
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
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ButtonWidget(
            title: 'NOVO DEFENSIVO',
            hasBorder: true,
            onClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewDefensivoScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

List<Fertilizante> fertilizantes = [
  Fertilizante(
    nome: "Nome fert 1",
    marca: "XXX",
    dataAplicacao: "26/06/21",
  ),
];

List<Defensivo> defensivos = [

];
