import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/imagefield_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../LanguageChangeProvider.dart';
import 'main_screens.dart';

class EditCanteiroScreen extends StatefulWidget {
  const EditCanteiroScreen({Key key}) : super(key: key);

  @override
  _EditCanteiroScreenState createState() => _EditCanteiroScreenState();
}

class _EditCanteiroScreenState extends State<EditCanteiroScreen> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  String _id_canteiro_escolhido = '';

  final _nameCanteiroController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameCanteiroController.text = "Canteiro Sul"; // TODO: puxar nome do canteiro do BD
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
          _id_canteiro_escolhido = (prefs.getString('id_canteiro_escolhido') ?? '');
        });

        String parametros = "?id_canteiro="+_id_canteiro_escolhido;
        http.Response url_teste = await http.post(
            "https://future-snowfall-319523.uc.r.appspot.com/delete-canteiro"+parametros);
        var response_login = url_teste.body;
        print(response_login);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreens(myInt:1)),
          //MaterialPageRoute(builder: (context) => CanteirosScreen()),
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void _changeLanguage(Language language) async {
      print(language.languageCode);
      setState(() {
        context.read<LanguageChangeProvider>().changeLocale(language.languageCode);      
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TitleFormsWidget(
                          titleText: 'Atualize \nseu canteiro',
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
                          'Preencha os campos abaixo e atualize as informações do seu canteiro.',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: 'Nome do canteiro',
                      prefixIconData: Icons.article_outlined,
                      obscureText: false,
                      textFieldController: _nameCanteiroController,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageFieldWidget(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()));
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                      title: 'ATUALIZAR',
                      hasBorder: false,
                      onClicked: () {
                        // TODO: subir informações do canteiro para nuvem
                        print('Nome: ${_nameCanteiroController.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CanteirosScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile; // TODO: essa imagem irá subir para o servidor - var _imageFile declarada lá encima
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Escolha uma imagem para o canteiro",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt_outlined),
                label: Text("Câmera"),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.file_upload_outlined),
                label: Text("Galeria"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
