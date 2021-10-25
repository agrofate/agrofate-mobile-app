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


class NewDefensivoScreen extends StatefulWidget {
  const NewDefensivoScreen({Key key}) : super(key: key);

  @override
  _NewDefensivoScreenState createState() => _NewDefensivoScreenState();
}

class _NewDefensivoScreenState extends State<NewDefensivoScreen> {
  final _nameDefController = TextEditingController();
  final _marcaDefController = TextEditingController();
  String _id_safra_escolhida = '';
  int _state = 0;

  DateTime date = DateTime(DateTime.now().year - 500);

  String getDateText() {
    //TODO: arrumar gambiarra - deveria ser date == null
    if (date == DateTime(DateTime.now().year - 500)) {
      return S.of(context).telaNovoDefensivoDataAplicacaoSelecao;
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.day}/${date.month}/${date.year}';
    }
  }

  adicionarDefensivo(nome_def, marca_def, data_def) async{    
    if(nome_def != ''){
      if(marca_def != ''){
        if(data_def.toString().split('-')[0] != '1521'){
          setState(() {
            _state = 1;
          });        
          SharedPreferences prefs = await SharedPreferences.getInstance();   
          _id_safra_escolhida = (prefs.getString('id_safra_atual') ?? ''); 
          String parametros = "?id_safra="+_id_safra_escolhida+"&nome_def="+nome_def+"&data_def="+data_def.toString()+"&marca_def="+marca_def;
          http.Response url_teste = await http.post(
              "https://intrepid-pager-329723.uc.r.appspot.com/insert-novo-defensivo"+parametros);
          var response_login = url_teste.body;
          print(response_login);
          setState(() {
            _state = 2;
          });
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailCanteiroScreen(), // TODO: enviar para canteiro que a safra foi adc
            ),
          );*/

          Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DetailCanteiroScreen()),
                  (Route<dynamic> route) => false,
                );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).telaNovoDefensivoDataAplicacaoInsercao))
          );
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).telaNovoDefensivoMarca))
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).telaNovoDefensivoNome))
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
                              S.of(context).telaNovoDefensivoTitulo,
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
                              S.of(context).telaNovoDefensivoDescricao,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: S.of(context).telaNovoDefensivoTFNome,
                      prefixIconData: Icons.article_outlined,
                      obscureText: false,
                      textFieldController: _nameDefController,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: S.of(context).telaNovoDefensivoTFMarca,
                      prefixIconData: Icons.business_center_outlined,
                      obscureText: false,
                      textFieldController: _marcaDefController,
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
                      title: S.of(context).telaNovoDefensivoBotaoAdicionar,
                      hasBorder: false,
                      onClicked: () {
                        // TODO: subir informações do defensivo p BD (nome; marca; date)
                        
                        adicionarDefensivo(_nameDefController.text, _marcaDefController.text, date);
                        /*print('Nome def: ${_nameDefController.text}');
                        print('Marca def: ${_marcaDefController.text}');
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
                              adicionarDefensivo(_nameDefController.text, _marcaDefController.text, date);
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
        S.of(context).telaNovoDefensivoBotaoAdicionar,
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
    }
  );

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }
}
