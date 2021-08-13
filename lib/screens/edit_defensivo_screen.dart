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

class EditDefensivoScreen extends StatefulWidget {
  const EditDefensivoScreen({Key key}) : super(key: key);

  @override
  _EditDefensivoScreenState createState() => _EditDefensivoScreenState();
}

class _EditDefensivoScreenState extends State<EditDefensivoScreen> {
  final _nameDefController = TextEditingController();
  final _marcaDefController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: puxar nome, marca e data do defensivo do BD
    _nameDefController.text = "Nome def 1";
    _marcaDefController.text = "Marca def 1";
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
