import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/screens/detail_canteiro_screen.dart';
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
  final _marcaFertController = TextEditingController();
  String _id_safra_escolhida = '';

  DateTime date = DateTime(DateTime.now().year - 500);

  String getDateText() {
    //TODO: arrumar gambiarra - deveria ser date == null
    if (date == DateTime(DateTime.now().year - 500)) {
      return 'Selecione a data de aplicação';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.day}/${date.month}/${date.year}';
    }
  }

  adicionarFertilizante(nome_fert, marca_fert, data_fert) async{
    if(nome_fert != ''){
      if(marca_fert != ''){
        if(data_fert.toString().split('-')[0] != '1521'){        
          SharedPreferences prefs = await SharedPreferences.getInstance();   
          _id_safra_escolhida = (prefs.getString('id_safra_atual') ?? ''); 
          String parametros = "?id_safra="+_id_safra_escolhida+"&nome_fert="+nome_fert+"&data_fert="+data_fert.toString()+"&marca_fert="+marca_fert;
          http.Response url_teste = await http.post(
              "https://future-snowfall-319523.uc.r.appspot.com/insert-novo-fertilizante"+parametros);
          var response_login = url_teste.body;
          print(response_login);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailCanteiroScreen(), // TODO: enviar para canteiro que a safra foi adc
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Insira a data de aplicação'))
          );
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insira a marca do Fertilizante'))
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira o nome do Fertilizante'))
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
                              'Adicione um \nnovo fertilizante',
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
                          'Preencha os campos abaixo e adicione um novo fertilizante à sua safra.',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: 'Nome do fertilizante',
                      prefixIconData: Icons.article_outlined,
                      obscureText: false,
                      textFieldController: _nameFertController,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: 'Marca do fertilizante',
                      prefixIconData: Icons.business_center_outlined,
                      obscureText: false,
                      textFieldController: _marcaFertController,
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
                    ButtonWidget(
                      title: 'ADICIONAR FERTILIZANTE',
                      hasBorder: false,
                      onClicked: () {
                        // TODO: subir informações da fertilizante (nome; marca; date)
                        adicionarFertilizante(_nameFertController.text, _marcaFertController.text, date);
                        /*print('Nome fert: ${_nameFertController.text}');
                        print('Marca fert: ${_marcaFertController.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCanteiroScreen(),
                          ),
                        );*/
                      },
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
}
