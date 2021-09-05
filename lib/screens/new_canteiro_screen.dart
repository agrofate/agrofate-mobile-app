import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
import 'package:agrofate_mobile_app/screens/main_screens.dart';
import 'package:agrofate_mobile_app/services/api.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/imagefield_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../LanguageChangeProvider.dart';

class NewCanteiroScreen extends StatefulWidget {
  const NewCanteiroScreen({Key key}) : super(key: key);

  @override
  _NewCanteiroScreenState createState() => _NewCanteiroScreenState();
}

class _NewCanteiroScreenState extends State<NewCanteiroScreen> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final picker = ImagePicker();
  CloudApi api;
  File _image;
  Uint8List _imageBytes;
  String _imageName;
  bool isUploaded = false;
  bool loading = false;
  final nameCanteiroController = TextEditingController();
  String _id_canteiro_escolhido = '';
  String _id_user = '';
  int _state = 0;

  void _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        _image = File(pickedFile.path);
        _imageBytes = _image.readAsBytesSync();
        _imageName = _image.path.split('/').last;
        isUploaded = false;
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveImage() async {
    setState(() {
      loading = true;
    });
    // Upload to Google cloud
    final response = await api.save(_imageName, _imageBytes);
    print(response);
    print(response.downloadLink);
    setState(() {
      loading = false;
      isUploaded = true;
    });
  }

  adicionarCanteiro(nome_cant) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id_user = (prefs.getString('id_user') ?? '');
      _state = 1;
    });
    if(nome_cant != ''){   
      final response = await api.save(_imageName, _imageBytes);
      print(response);
      print(response.downloadLink);
      setState(() {
        loading = false;
        isUploaded = true;
      });    
      SharedPreferences prefs = await SharedPreferences.getInstance();   
      String parametros = "?nome_canteiro="+nome_cant+"&id_usuario="+_id_user+"&imagem_canteiro="+response.downloadLink.toString();
      http.Response url_teste = await http.post(
          "https://future-snowfall-319523.uc.r.appspot.com/insert-novo-canteiro"+parametros);
      var response_login = url_teste.body;
      print(response_login);
      setState(() {
        _state = 2;
      });
      /*Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CanteirosScreen(),
                  ),
                );*/
      Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreens(myInt:1)),
                  (Route<dynamic> route) => false,
                );
    
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira o nome do Canteiro'))
      );
    }
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/cloud/credentials.json').then((json) {
      api = CloudApi(json);
    });
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TitleFormsWidget(
                          titleText: 'Adicione \num canteiro',
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
                              'Preencha os campos abaixo e crie um novo canteiro.',
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
                      textFieldController: nameCanteiroController,
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
                    /*ButtonWidget(
                      title: 'ADICIONAR',
                      hasBorder: false,
                      onClicked: () {
                        // TODO: subir informações do canteiro para nuvem
                        
                        adicionarCanteiro(nameCanteiroController.text);
                        /*print('Nome: ${nameCanteiroController.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CanteirosScreen(),
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
                              adicionarCanteiro(nameCanteiroController.text);
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    _image = File(pickedFile.path);
    _imageBytes = _image.readAsBytesSync();
    _imageName = _image.path.split('/').last;
    isUploaded = false;
    print(pickedFile.path);
    setState(() {
      _imageFile = pickedFile;
      loading = true; // TODO: essa imagem irá subir para o servidor - var _imageFile declarada lá encima
    });
    
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        S.of(context).telaNovoCanteiroAdicionar,
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
