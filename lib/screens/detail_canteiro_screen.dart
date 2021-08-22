import 'dart:convert';

import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
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
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../LanguageChangeProvider.dart';

class DetailCanteiroScreen extends StatefulWidget {
  const DetailCanteiroScreen({Key key}) : super(key: key);

  @override
  _DetailCanteiroScreenState createState() => _DetailCanteiroScreenState();
}

class _DetailCanteiroScreenState extends State<DetailCanteiroScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  String _id_canteiro_escolhido = '';
  String _nome_canteiro_escolhido = '';
  String _imagem_canteiro_escolhido = '';
  String _condicao_imagem_escolhido;
  bool loading = true;
  bool loading_safra = true;
  bool loading_safra_detalhe = true;
  bool loading_fertilizante = true;
  bool loading_fertilizante_detalhe = true;
  bool loading_defensivo = true;
  bool loading_defensivo_detalhe = true;
  var safra_data;
  var nome_canteiro;
  var nome_safra;
  var data_plantacao;
  var nome_cultura;
  var fert_data;
  var def_data;

  var months = [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']; 
  List data = [
    {"name": "Jan"},{"name": "Feb"},{"name": "Mar"},{"name": "Apr"},{"name": "May"},{"name": "Jun"},{"name": "Jul"},{"name": "Aug"},{"name": "Sep"},{"name": "Oct"},{"name": "Nov"},{"name": "Dec"},
  ];

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
      _nome_canteiro_escolhido = (prefs.getString('nome_canteiro_escolhido') ?? '');
      _imagem_canteiro_escolhido = (prefs.getString('imagem_canteiro_escolhido') ?? "assets/images/canteiro_padrao.jpg");
      _condicao_imagem_escolhido = (prefs.getString('condicao_imagem_escolhido').toLowerCase() ?? 'false');
    });
    print(_id_canteiro_escolhido);
    print(_nome_canteiro_escolhido);
    print(_imagem_canteiro_escolhido);
    print(_condicao_imagem_escolhido);

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
              //DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
              //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(fert_data[0][4]);
              int trendIndex = data.indexWhere((f) => f['name'] == fert_data[0][4].split(" ")[2]);
              print(trendIndex);
              this.loading_fertilizante = false;
              this.loading_fertilizante_detalhe = true;
            });
          }
        }

        String parametros_def = "?id_safra=" + response_login[0][0].toString();
        print(parametros_def);
        http.Response url_teste_def = await http.get(
            "https://future-snowfall-319523.uc.r.appspot.com/read-one-defensivo" +
                parametros_def);
        var response_login_def = jsonDecode(url_teste_def.body).asMap();
        print("Linha 95: ");
        print(response_login_def.length);
        if (response_login_def.length > 0) {
          print(response_login_def[0][0]);
          if (response_login_def[0][0] == 0) {
            setState(() {
              this.loading_defensivo = false;
              this.loading_defensivo_detalhe = false;
            });
          } else {
            setState(() {
              def_data = response_login_def;
              this.loading_defensivo = false;
              this.loading_defensivo_detalhe = true;
            });
          }
        }
      }
    }
  }


  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(S.of(context).telaDetalheCanteiroAlertEscolha1),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(S.of(context).telaDetalheCanteiroAlertEscolha2),
      onPressed:  () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(S.of(context).telaDetalheCanteiroAlertTitle),
      content: Text(S.of(context).telaDetalheCanteiroAlertDescricao),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _defensivoEscolhido(id_defensivo, nome_def, marca_def, data_def) async {
    print(id_defensivo);
    print(nome_def);
    print(marca_def);
    print(data_def);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('id_defensivo_escolhido', id_defensivo.toString());
      prefs.setString('nome_defensivo_escolhido', nome_def.toString());
      prefs.setString('marca_defensivo_escolhido', marca_def.toString());
      prefs.setString('data_defensivo_escolhido', data_def.toString());
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDefensivoScreen(),
      ),
    );
  }

  _fertilizanteEscolhido(id_fertilizante, nome_fert, marca_fert, data_fert) async {
    print(id_fertilizante);
    print(nome_fert);
    print(marca_fert);
    print(data_fert);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('id_fertilizante_escolhido', id_fertilizante.toString());
      prefs.setString('nome_fertilizante_escolhido', nome_fert.toString());
      prefs.setString('marca_fertilizante_escolhido', marca_fert.toString());
      prefs.setString('data_fertilizante_escolhido', data_fert.toString());
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFertilizanteScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Language>(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
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
                    image: _condicao_imagem_escolhido == "true" ? DecorationImage(image: NetworkImage(_imagem_canteiro_escolhido),fit: BoxFit.cover,):DecorationImage(image: AssetImage(_imagem_canteiro_escolhido),fit: BoxFit.cover),
                    /*image: DecorationImage(
                      image: AssetImage(
                        "assets/images/canteiro_padrao.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),*/
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
                              S.of(context).telaDetalheCanteiroAdicionarSafra,
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
                          title: S.of(context).telaDetalheCanteiroTituloSafra,
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
                          title: S.of(context).telaDetalheCanteiroTituloHistorico,
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
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  S.of(context).telaDetalheCanteiroMensagemHistorico)));
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
                                    S.of(context).telaDetalheCanteiroDataPlantacao + data_plantacao.split(" ")[1]+"/"+data.indexWhere((f) => f['name'] == data_plantacao.split(" ")[2]).toString()+"/"+data_plantacao.split(" ")[3], //data_plantacao,
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
                                  /*Text(
                                    S.of(context).telaDetalheCanteiroUltimaAtualizacao + "27/06/21",
                                    // TODO: recuperar data de última atualização da safra do BD
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),*/
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).telaDetalheCanteiroCultura + nome_cultura,
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
                                          text: S.of(context).telaDetalheCanteiroTabFertilizante,
                                        ),

                                        // second tab [you can add an icon using the icon property]
                                        Tab(
                                          text: S.of(context).telaDetalheCanteiroTabDefensivo,
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
                                              return Column(
                                                children: [
                                                  Container(                                                    
                                                    height: (size.height * 0.42) - 70,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    child: ButtonWidget(
                                                      title: S.of(context).telaDetalheCanteiroTituloNovoFertilizante,
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
                                                  )
                                                ]);
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
                                                                          S.of(context).telaDetalheCanteiroDefensivoMarca +
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
                                                                          S.of(context).telaDetalheCanteiroDefensivoDataAplicacao +
                                                                              fert_data[index][4].split(" ")[1]+"/"+ (data.indexWhere((f) => f['name'] == fert_data[index][4].split(" ")[2])+1).toString()+"/"+fert_data[index][4].split(" ")[3],
                                                                              //fert_data[index][4],
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
                                                                        /*Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                EditFertilizanteScreen(),
                                                                          ),
                                                                        );*/
                                                                        _fertilizanteEscolhido(fert_data[index][0], fert_data[index][2], fert_data[index][3], fert_data[index][4].split(" ")[3]+"-0"+(data.indexWhere((f) => f['name'] == fert_data[index][4].split(" ")[2])+1).toString()+"-"+fert_data[index][4].split(" ")[1]);
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
                                                          S.of(context).telaDetalheCanteiroTituloNovoFertilizante,
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
                                        FutureBuilder(builder: (context, text) {
                                          if (loading_defensivo) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            if (!loading_defensivo_detalhe) {
                                              return Column(
                                                children: [
                                                  Container(                                                    
                                                    height: (size.height * 0.42) - 70,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    child: ButtonWidget(
                                                      title: S.of(context).telaDetalheCanteiroTituloNovoDefensivo,
                                                      hasBorder: true,
                                                      onClicked: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                NewDefensivoScreen(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ]);
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
                                                          def_data.length,
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
                                                                          def_data[index]
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
                                                                          S.of(context).telaDetalheCanteiroDefensivoMarca +
                                                                              def_data[index][3],
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
                                                                          S.of(context).telaDetalheCanteiroDefensivoDataAplicacao +
                                                                              def_data[index][4].split(" ")[1]+"/"+(data.indexWhere((f) => f['name'] == def_data[index][4].split(" ")[2])+1).toString()+"/"+def_data[index][4].split(" ")[3],
                                                                              //fert_data[index][4],
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
                                                                        /*Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                EditDefensivoScreen(),
                                                                          ),
                                                                        );*/
                                                                        _defensivoEscolhido(def_data[index][0], def_data[index][2], def_data[index][3], def_data[index][4].split(" ")[3]+"-0"+(data.indexWhere((f) => f['name'] == def_data[index][4].split(" ")[2])+1).toString()+"-"+def_data[index][4].split(" ")[1]);
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
                                                          S.of(context).telaDetalheCanteiroTituloNovoDefensivo,
                                                      hasBorder: true,
                                                      onClicked: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                NewDefensivoScreen(),
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
                                        //buildDefensivoList(size),
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
                                  title: S.of(context).telaDetalheCanteiroTituloFinalizarSafra,
                                  hasBorder: false,
                                  onClicked: () {
                                    // todo: finalizar safra botao
                                    showAlertDialog(context);
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
          title: S.of(context).telaDetalheCanteiroTituloNovoFertilizante,
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
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditDefensivoScreen(),
                                ),
                              );*/                              
                              _defensivoEscolhido(def_data[index][0], def_data[index][2], def_data[index][3], def_data[index][4].split(" ")[3]+"-"+(data.indexWhere((f) => f['name'] == def_data[index][4].split(" ")[2])+1).toString()+"-"+def_data[index][4].split(" ")[1]);
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
  Defensivo(
    nome: "Nome def 1",
    marca: "XXX",
    dataAplicacao: "26/06/21",
  ),
];
