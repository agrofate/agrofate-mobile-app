import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
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

class EditFertilizanteScreen extends StatefulWidget {
  const EditFertilizanteScreen({Key key}) : super(key: key);

  @override
  _EditFertilizanteScreenState createState() => _EditFertilizanteScreenState();
}

class _EditFertilizanteScreenState extends State<EditFertilizanteScreen> {
  final _nameFertController = TextEditingController();
  final _marcaFertController = TextEditingController();
  String _id_fertilizante_escolhido = '';
  String _nome_fertilizante_escolhido = '';
  String _marca_fertilizante_escolhido = '';
  String _data_fertilizante_escolhido = '';

  @override
  void initState() {
    super.initState();
    iniciaCampos();
  }
  iniciaCampos() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _id_fertilizante_escolhido = (prefs.getString('id_fertilizante_escolhido') ?? '');
      _nome_fertilizante_escolhido = (prefs.getString('nome_fertilizante_escolhido') ?? '');
      _marca_fertilizante_escolhido = (prefs.getString('marca_fertilizante_escolhido') ?? '');
      _data_fertilizante_escolhido = (prefs.getString('data_fertilizante_escolhido') ?? '');
    });
    // TODO: puxar nome, marca e data do defensivo do BD
    _nameFertController.text = _nome_fertilizante_escolhido;
    _marcaFertController.text = _marca_fertilizante_escolhido;
    print(new DateTime.now());
    date =  DateTime.parse(_data_fertilizante_escolhido);
  }

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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(S.of(context).telaEditarCanteiroAlertEscolha1),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(S.of(context).telaEditarCanteiroAlertEscolha2),
      onPressed:  () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        setState(() {
          _id_fertilizante_escolhido = (prefs.getString('id_fertilizante_escolhido') ?? '');
        });
        print(_id_fertilizante_escolhido);
        String parametros = "?id_fertilizante="+_id_fertilizante_escolhido;
        http.Response url_teste = await http.post(
            "https://future-snowfall-319523.uc.r.appspot.com/delete-fertilizante"+parametros);
        var response_login = url_teste.body;
        print(response_login);
        Navigator.push(
          context,
          //MaterialPageRoute(builder: (context) => MainScreens(myInt:1)),
          MaterialPageRoute(builder: (context) => DetailCanteiroScreen()),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(S.of(context).telaEditarFertilizanteAlertTitle),
      content: Text(S.of(context).telaEditarFertilizanteAlertDescricao),
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void _changeLanguage(Language language) async {
      print(language.languageCode);
      setState(() {
        context.read<LanguageChangeProvider>().changeLocale(language.languageCode);      
      });
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
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.black,
            ),
            onPressed: () {
              showAlertDialog(context);
            },
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            TitleFormsWidget(
                              titleText:
                              S.of(context).telaEditarFertilizanteTitulo,
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
                          S.of(context).telaEditarFertilizanteDescricao,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: S.of(context).telaEditarFertilizanteNome,
                      prefixIconData: Icons.article_outlined,
                      obscureText: false,
                      textFieldController: _nameFertController,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: S.of(context).telaEditarFertilizanteTipo,
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
                      title: S.of(context).telaEditarFertilizanteBotao,
                      hasBorder: false,
                      onClicked: () {
                        // TODO: subir informações da fertilizante (nome; marca; date)
                        print('Nome fert: ${_nameFertController.text}');
                        print('Tipo fert: ${_marcaFertController.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCanteiroScreen(),
                          ),
                        );
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
