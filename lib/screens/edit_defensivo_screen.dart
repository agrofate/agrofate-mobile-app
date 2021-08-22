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
import 'canteiros_screen.dart';

class EditDefensivoScreen extends StatefulWidget {
  const EditDefensivoScreen({Key key}) : super(key: key);

  @override
  _EditDefensivoScreenState createState() => _EditDefensivoScreenState();
}

class _EditDefensivoScreenState extends State<EditDefensivoScreen> {
  final _nameDefController = TextEditingController();
  final _marcaDefController = TextEditingController();
  String _id_defensivo_escolhido = '';
  String _nome_defensivo_escolhido = '';
  String _marca_defensivo_escolhido = '';
  String _data_defensivo_escolhido = '';

  @override
  Future<void> initState() {
    super.initState();
    iniciaCampos();
  }

  iniciaCampos() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _id_defensivo_escolhido = (prefs.getString('_id_defensivo_escolhido') ?? '');
      _nome_defensivo_escolhido = (prefs.getString('nome_defensivo_escolhido') ?? '');
      _marca_defensivo_escolhido = (prefs.getString('marca_defensivo_escolhido') ?? '');
      _data_defensivo_escolhido = (prefs.getString('data_defensivo_escolhido') ?? '');
    });
    // TODO: puxar nome, marca e data do defensivo do BD
    _nameDefController.text = _nome_defensivo_escolhido;
    _marcaDefController.text = _marca_defensivo_escolhido;
    print(new DateTime.now());
    date =  DateTime.parse(_data_defensivo_escolhido);
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
          _id_defensivo_escolhido = (prefs.getString('id_defensivo_escolhido') ?? '');
        });
        print(_id_defensivo_escolhido);
        String parametros = "?id_defensivo="+_id_defensivo_escolhido;
        http.Response url_teste = await http.post(
            "https://future-snowfall-319523.uc.r.appspot.com/delete-defensivo"+parametros);
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
      title: Text(S.of(context).telaEditarCanteiroAlertTitle),
      content: Text(S.of(context).telaEditarCanteiroAlertDescricao),
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
                              'Edite o \ndefensivo',
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
                          'Preencha os campos abaixo e atualize o defensivo.',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: 'Nome do defensivo',
                      prefixIconData: Icons.article_outlined,
                      obscureText: false,
                      textFieldController: _nameDefController,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: 'Marca do defensivo',
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
                    ButtonWidget(
                      title: 'ATUALIZAR DEFENSIVO',
                      hasBorder: false,
                      onClicked: () {
                        // TODO: subir informações da defensivo (nome; marca; date)
                        print('Nome def: ${_nameDefController.text}');
                        print('Marca def: ${_marcaDefController.text}');
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
