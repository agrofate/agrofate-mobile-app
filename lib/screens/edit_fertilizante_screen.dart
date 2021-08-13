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

import '../LanguageChangeProvider.dart';

class EditFertilizanteScreen extends StatefulWidget {
  const EditFertilizanteScreen({Key key}) : super(key: key);

  @override
  _EditFertilizanteScreenState createState() => _EditFertilizanteScreenState();
}

class _EditFertilizanteScreenState extends State<EditFertilizanteScreen> {
  final _nameFertController = TextEditingController();
  final _marcaFertController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: puxar nome, marca e data do fertilizante do BD
    _nameFertController.text = "Nome fert 1";
    _marcaFertController.text = "Marca fert 1";
    date = DateTime.now();
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
            onPressed: () {},
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
                              'Edite o \nfertilizante',
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
                          'Preencha os campos abaixo e atualize o fertilizante.',
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
                      hintText: 'Tipo do fertilizante',
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
                      title: 'ATUALIZAR FERTILIZANTE',
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
