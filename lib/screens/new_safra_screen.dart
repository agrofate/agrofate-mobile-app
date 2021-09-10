import 'dart:async';
import 'dart:convert';

import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/datepicker_widget.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/imagefield_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../LanguageChangeProvider.dart';

class NewSafraScreen extends StatefulWidget {
  const NewSafraScreen({Key key}) : super(key: key);

  @override
  _NewSafraScreenState createState() => _NewSafraScreenState();
}

class _NewSafraScreenState extends State<NewSafraScreen> {
  final _nameSafraController = TextEditingController();
  var nome_canteiro;
  bool loading = true;
  //var data_cultura;
  List data_cultura = List.empty();
  String countryid; 
  var _mySelection;
  int _state = 0;

  String dropdownValue = '';
  String _id_canteiro_escolhido = '';
  String hintValue = 'Selecione a cultura';
  List<String> culturasItems = [
    "Couve",
    "Alface"
  ]; // TODO: puxar lista de culturas do banco?

  DateTime date = DateTime(DateTime.now().year - 500);

  @override
  void initState() {
    super.initState();
    _procuraNomeCanteiro();
    procuraCultura();
  }

  adicionarSafra(nome_safra, data_safra, tipo_cultura) async{
    if(nome_safra != ''){
      if(data_safra.toString().split('-')[0] != '1521'){
        if(tipo_cultura != null){
          setState(() {
            _state = 1;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();             
          _id_canteiro_escolhido =  (prefs.getString('id_canteiro_escolhido') ?? ''); 
          print(_id_canteiro_escolhido);
          print(nome_safra);
          print(data_safra.toString());
          print(tipo_cultura);
          String parametros = "?id_canteiro="+_id_canteiro_escolhido+"&nome_safra="+nome_safra+"&data_safra="+data_safra.toString()+"&id_cultura="+tipo_cultura;
          http.Response url_teste = await http.post(
              "https://future-snowfall-319523.uc.r.appspot.com/insert-nova-safra"+parametros);
          var response_login = url_teste.body;
          print(response_login);
          setState(() {
            _state = 2;
          });
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CanteirosScreen(), // TODO: enviar para canteiro que a safra foi adc
            ),
          );*/
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CanteirosScreen()),
            (Route<dynamic> route) => false,
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Insira o tipo da cultura'))
          );
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insira a data da Safra'))
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira o nome da Safra'))
      );
    }
    print(nome_safra);
    print(data_safra);
    print(tipo_cultura);
  }

  Future procuraCultura() async {
    http.Response url_teste = await http.get(
        "https://future-snowfall-319523.uc.r.appspot.com/read-all-cultura");
    var response_login = jsonDecode(url_teste.body);
    data_cultura = response_login;
    print(response_login);
    print(response_login.length);

    setState(() {
      data_cultura = response_login;
      loading = false;
    });
  }

  Future _procuraNomeCanteiro() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nome_canteiro =  (prefs.getString('nome_canteiro_escolhido') ?? '');
    setState(() {        
      nome_canteiro = (prefs.getString('nome_canteiro_escolhido') ?? '');
    });
  }

  String getDateText(){    
    //TODO: arrumar gambiarra - deveria ser date == null
    if (date == DateTime(DateTime.now().year - 500)) {
      return 'Selecione a data de plantação';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.day}/${date.month}/${date.year}';
    }
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

    Future pickDate(BuildContext context) async {
      final initialDate = DateTime.now();
      final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        locale: Locale('pt', 'BR'),
      );

      if (newDate == null) return;

      setState(() {
        // TODO: enviar date para BD
        date = newDate;
      });
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
      body: Form(
        child: 
        FutureBuilder(
          builder: (context, text){
            if (loading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
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
                              Wrap(
                                children: [
                                  TitleFormsWidget(
                                    // TODO: recuperar nome do canteiro na base
                                    titleText:
                                        'Adicione uma safra no \n' + nome_canteiro,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: [
                              DescriptionFormsWidget(
                                descriptionText:
                                    'Preencha os campos abaixo e adicione uma nova safra ao seu canteiro.',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          TextFieldWidget(
                            hintText: 'Nome da safra',
                            prefixIconData: Icons.article_outlined,
                            obscureText: false,
                            textFieldController: _nameSafraController,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DatePickerWidget(
                            text: getDateText(),
                            onTap: () {
                              pickDate(context);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 53,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: const Border.fromBorderSide(BorderSide.none),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.seedling,
                                  size: 18,
                                  color: Color(0xff575c63),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: size.width * 0.67,
                                  child: Center(
                                    /*child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: new Text(hintValue),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        iconSize: 24,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: const TextStyle(
                                          color: Color(0xff575c63),
                                          fontSize: 14.0,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                            hintValue = dropdownValue;
                                          });
                                        },
                                        items: data_cultura
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: data_cultura[0],
                                            child: Text(data_cultura[1]),
                                          );
                                        }).toList(),
                                      ),
                                    ),*/
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: new Text(hintValue),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        iconSize: 24,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: const TextStyle(
                                          color: Color(0xff575c63),
                                          fontSize: 14.0,
                                        ),
                                        items: data_cultura.map((item) {
                                          return new DropdownMenuItem(
                                            child: new Text(
                                              item[1],   
                                              style: TextStyle(
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            value: item[0].toString()                                                                         
                                          );  
                                        }).toList(),
                                        onChanged: (String newVal) {
                                          setState(() {
                                            countryid = newVal;
                                            print(countryid.toString());
                                          });
                                        },
                                        value: countryid, 
                                      )
                                    )
                                    /*child: new DropdownButton(
                                      items: data_cultura.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item[1]),
                                          value: item[0].toString(),
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          _mySelection = newVal;
                                        });
                                      },
                                      value: _mySelection,
                                    ),*/
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          /*ButtonWidget(
                            title: 'ADICIONAR SAFRA',
                            hasBorder: false,
                            onClicked: () {
                              // TODO: subir informações da safra para nuvem (nome; date; dropdownValue)
                              print('Safra: ${_nameSafraController.text}');
                              adicionarSafra(_nameSafraController.text, date, countryid);
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CanteirosScreen(), // TODO: enviar para canteiro que a safra foi adc
                                ),
                              );*/
                            },
                          ),*/

                          Padding(                  
                            padding: const EdgeInsets.all(0.0),                        
                            child: new MaterialButton(
                              child: setUpButtonChild(),                    
                              onPressed: () {
                                setState(() {
                                  if (_state == 0) {
                                    adicionarSafra(_nameSafraController.text, date, countryid);
                                  }
                                });
                              },
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              elevation: 0,
                              hoverElevation: 0,
                              focusElevation: 0,
                              highlightElevation: 0,
                              minWidth: double.infinity,
                              height: 58.0,
                              color: kGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        S.of(context).telaNovaSafraBotaoAdicionar,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }
}
