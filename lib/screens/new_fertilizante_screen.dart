import 'dart:async';

import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/screens/detail_canteiro_screen.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/datepicker_widget.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../LanguageChangeProvider.dart';

class NewFertilizanteScreen extends StatefulWidget {
  const NewFertilizanteScreen({Key key}) : super(key: key);

  @override
  _NewFertilizanteScreenState createState() => _NewFertilizanteScreenState();
}

class _NewFertilizanteScreenState extends State<NewFertilizanteScreen> {
  final _nameFertController = TextEditingController();
  final _tipoFertController = TextEditingController();
  String _id_safra_escolhida = '';
  bool pressedButton = false;
  int _state = 0;

  DateTime date = DateTime(DateTime.now().year - 500);

  String getDateText() {
    //TODO: arrumar gambiarra - deveria ser date == null
    if (date == DateTime(DateTime.now().year - 500)) {
      return S.of(context).telaNovoFertilizanteDataAplicacaoSelecao;
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.day}/${date.month}/${date.year}';
    }
  }

  adicionarFertilizante(nome_fert, tipo_fert, data_fert) async{
    if(nome_fert != ''){
      if(tipo_fert != ''){
        if(data_fert.toString().split('-')[0] != '1521'){  
          setState(() {     
            pressedButton = true; 
            _state = 1;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();   
          _id_safra_escolhida = (prefs.getString('id_safra_atual') ?? ''); 
          String parametros = "?id_safra="+_id_safra_escolhida+"&nome_fert="+nome_fert+"&data_fert="+data_fert.toString()+"&marca_fert="+tipo_fert;
          http.Response url_teste = await http.post(
              "https://future-snowfall-319523.uc.r.appspot.com/insert-novo-fertilizante"+parametros);
          var response_login = url_teste.body;
          print(response_login);
          setState(() {
            _state = 2;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailCanteiroScreen(), // TODO: enviar para canteiro que a safra foi adc
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).telaNovoFertilizanteDataAplicacaoInsercao))
          );
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Insira o tipo do Fertilizante'))
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insira o nome do Fertilizante'))
      );
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
        child: SingleChildScrollView(
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
                              titleText:
                              S.of(context).telaNovoFertilizanteTitulo,
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
                              S.of(context).telaNovoFertilizanteDescricao,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: S.of(context).telaNovoFertilizanteTFNome,
                      prefixIconData: Icons.article_outlined,
                      obscureText: false,
                      textFieldController: _nameFertController,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: S.of(context).telaNovoFertilizanteTFMarca,
                      prefixIconData: Icons.business_center_outlined,
                      obscureText: false,
                      textFieldController: _tipoFertController,
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
                      height: 20,
                    ),
                    /*ButtonWidget(
                      title: S.of(context).telaNovoFertilizanteBotaoAdicionar,
                      hasBorder: false,
                      onClicked: () {
                        // TODO: subir informações da fertilizante (nome; marca; date)
                      
                        if (!pressedButton) {
                          // await Your normal function
                          adicionarFertilizante(_nameFertController.text, _tipoFertController.text, date); 
                        } else {
                          return null;
                        }                     
                        /*print('Nome fert: ${_nameFertController.text}');
                        print('tipo fert: ${_tipoFertController.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCanteiroScreen(),
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
                              adicionarFertilizante(_nameFertController.text, _tipoFertController.text, date); 
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
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        S.of(context).telaNovoFertilizanteBotaoAdicionar,
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
