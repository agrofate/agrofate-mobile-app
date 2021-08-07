import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/screens/forecast_screen.dart';
import 'package:agrofate_mobile_app/screens/main_screens.dart';
import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
// import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LanguageChangeProvider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  onClickedCadastrar(nome, email, senha) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();    
    String parametros = "?nome="+nome+"&email="+email+"&senha="+senha;
    http.Response url_teste = await http.post(
        "https://future-snowfall-319523.uc.r.appspot.com/create-login"+parametros);
    var response_login = url_teste.body;
    print(response_login);
    if(response_login == "Login cadastrado"){
      prefs.setString('email', email);
      prefs.setString('senha', senha);
      Navigator.push(
        context,
        //MaterialPageRoute(builder: (context) => MainScreens()),
        MaterialPageRoute(builder: (context) => CanteirosScreen()),
      );
    }else{
      _exibirDialogoErro(response_login);
    }
  }

  void _exibirDialogoErro(mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Login não cadastrado"),
          content: new Text(mensagem),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
          ],
        );
      },
    );
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TitleFormsWidget(
                          titleText: 'Crie uma \nnova conta',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DescriptionFormsWidget(
                      descriptionText:
                          'Preencha os campos abaixo e crie sua conta na agrofate.',
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: 'Nome',
                      prefixIconData: Icons.person_outline,
                      obscureText: false,
                      textFieldController: nameController,
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: 'Email',
                      prefixIconData: Icons.mail_outline,
                      obscureText: false,
                      textFieldController: emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: 'Senha',
                      prefixIconData: Icons.lock_outline,
                      obscureText: true,
                      textFieldController: passwordController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        title: 'CADASTRAR',
                        hasBorder: false,
                        onClicked: () {
                          print('Nome: ${nameController.text}');
                          print('Email: ${emailController.text}');
                          print('Senha: ${passwordController.text}');                          
                          onClickedCadastrar(nameController.text, emailController.text, passwordController.text);
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreens()),
                          );*/
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
