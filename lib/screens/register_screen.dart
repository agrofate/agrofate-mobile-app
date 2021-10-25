import 'dart:async';
import 'dart:convert';

import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/screens/forecast_screen.dart';
import 'package:agrofate_mobile_app/screens/main_screens.dart';
import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
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

import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:steel_crypt/steel_crypt.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int _state = 0;
  var key = "null";
  String encryptedS,decryptedS;
  PlatformStringCryptor cryptor;
  var _senha;

  Encrypt(password) async{
    cryptor = PlatformStringCryptor();
    final salt = await cryptor.generateSalt();
    key = await cryptor.generateKeyFromPassword(password, salt);
    // here pass the password entered by user and the key
    encryptedS = await cryptor.encrypt(password, key);
    return encryptedS;
  }
  
  // method to decrypt String Password
  Decrypt(password) async{
    try{
      //here pass encrypted string and the key to decrypt it 
      decryptedS = await cryptor.decrypt(password, key);
      print(decryptedS);
      return decryptedS;
    }on MacMismatchException{
    }
  }

  onClickedCadastrar(nome, email, senha) async {
    if(isEmail(email)){
      setState(() {
        _state = 1;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var fortunaKey = CryptKey().genFortuna(); //generate 32 byte key with Fortuna; you can also enter your own
      var nonce = CryptKey().genDart(len: 12); //generate IV for AES with Dart Random.secure(); you can also enter your own
      var aesEncrypter = AesCrypt(key: fortunaKey, padding: PaddingAES.pkcs7); //generate AES encrypter with key and PKCS7 padding
      String encrypted = aesEncrypter.gcm.encrypt(inp: senha, iv: nonce); //encrypt using GCM
      String decrypted = aesEncrypter.gcm.decrypt(enc: encrypted, iv: nonce); //decrypt
      print(encrypted);
      print(decrypted);
      setState(() {
        _state = 0;
      });
      
      String parametros = "?nome="+nome+"&email="+email+"&senha='"+encrypted.toString()+"'&chave='"+nonce.toString()+"'&fortuna='"+fortunaKey.toString()+"'";
      print(parametros);
      http.Response url_teste = await http.post(
          "https://intrepid-pager-329723.uc.r.appspot.com/create-login-chave"+parametros);
      var response_login = url_teste.body;
      print(response_login);
      if(response_login == "Login cadastrado"){        
        prefs.setString('email', email);
        prefs.setString('senha', senha);

        String parametros = "?email="+email+"&senha="+senha;
        http.Response url_teste = await http.get(
            "https://intrepid-pager-329723.uc.r.appspot.com/read-one"+parametros);
        var response_login1 = jsonDecode(url_teste.body)[0].asMap();
        print(response_login1);
        if(response_login1.length > 1){
          setState(() {
            _state = 2;
          });
          prefs.setString('id_user', response_login1[0].toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreens()),
            //MaterialPageRoute(builder: (context) => CanteirosScreen()),
          );
        }
      }else{
        setState(() {
          _state = 0;
        });
        _exibirDialogoErro(response_login);
      }
    }else{
      setState(() {
        _state = 0;
      });
      _exibirDialogoErro("Email inválido. Tente novamente!");
    } 
  }

  bool isEmail(String string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ),
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
                          titleText: S.of(context).telaCadastrarLoginTitulo,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DescriptionFormsWidget(
                      descriptionText:
                          S.of(context).telaCadastrarLoginDescricao,
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: S.of(context).telaCadastrarLoginNome,
                      prefixIconData: Icons.person_outline,
                      obscureText: false,
                      textFieldController: nameController,
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: S.of(context).telaCadastrarLoginEmail,
                      prefixIconData: Icons.mail_outline,
                      obscureText: false,
                      textFieldController: emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: S.of(context).telaCadastrarLoginSenha,
                      prefixIconData: Icons.lock_outline,
                      obscureText: true,
                      textFieldController: passwordController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*ButtonWidget(
                        title: S.of(context).telaCadastrarLoginBotao,
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
                        }
                    ),*/
                    Padding(                  
                      padding: const EdgeInsets.all(0.0),                        
                      child: new MaterialButton(
                        child: setUpButtonChild(),                    
                        onPressed: () {
                          setState(() {
                            if (_state == 0) {
                              onClickedCadastrar(nameController.text, emailController.text, passwordController.text);
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

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        S.of(context).telaCadastrarLoginBotao,
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
