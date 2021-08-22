import 'dart:async';
import 'dart:convert';

import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/screens/main_screens.dart';
import 'package:agrofate_mobile_app/screens/register_screen.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
// import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/wave_widget.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../LanguageChangeProvider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  String password = '';
  bool isPasswordVisible = true;
  int _state = 0;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  void _exibirDialogo(mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Erro ao logar"),
          content: new Text(mensagem[0]),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                /*Navigator.of(context).pop();
                if(mensagem[0] != "Senha incorreta"){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                    ModalRoute.withName("/"),
                  );
                }   */             
              },
            ),
          ],
        );
      },
    );
  }

  onClickedEntrar(email, senha) async {
    setState(() {
      _state = 1;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();    
    print(email);
    print(senha);
    String parametros = "?email="+email+"&senha="+senha;
    http.Response url_teste = await http.get(
        "https://future-snowfall-319523.uc.r.appspot.com/read-one"+parametros);
    var response_login = jsonDecode(url_teste.body)[0].asMap();
    print(response_login);
    if(response_login.length > 1){
      setState(() {
        _state = 2;
      });
      prefs.setString('id_user', response_login[0].toString());
      prefs.setString('email', email);
      prefs.setString('senha', senha);
      await FlutterSession().set('token', email);
      String parametros_sessao = "?id_usuario="+response_login[0].toString();
      http.Response url_teste_sessao = await http.post(
          "https://future-snowfall-319523.uc.r.appspot.com/update-user-sessao"+parametros_sessao);
      var response_login_sessao = jsonDecode(url_teste_sessao.body)[0].asMap();
      print(response_login_sessao);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreens(myInt:0)),
        //MaterialPageRoute(builder: (context) => CanteirosScreen()),
      );
    }else{
      setState(() {
        _state = 0;
      });
      _exibirDialogo(response_login);
    }
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreens()),
    );*/
  }

  Widget buildEmail() {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      obscureText: false,
      style: TextStyle(
        color: Color(0xff575c63),
        fontSize: 14.0,
      ),
      cursorColor: Color(0xff575c63),
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(
          Icons.mail_outline,
          size: 18,
          color: Color(0xff575c63),
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kGreenColor),
        ),
        suffixIcon: emailController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(
                  Icons.close,
                  size: 18,
                ),
                color: Color(0xff575c63),
                onPressed: () => emailController.clear(),
              ),
        labelStyle: const TextStyle(
          color: Color(0xff575c63),
        ),
        focusColor: Color(0xff575c63),
      ),
    );
  }

  Widget buildPassword() {
    return TextField(
      onChanged: (value) => setState(() => this.password = value),
      onSubmitted: (value) => setState(() => this.password = value),
      textInputAction: TextInputAction.done,
      obscureText: isPasswordVisible,
      style: TextStyle(
        color: Color(0xff575c63),
        fontSize: 14.0,
      ),
      cursorColor: Color(0xff575c63),
      decoration: InputDecoration(
        labelText: S.of(context).telaLoginCampoSenha,
        // errorText: 'E-mail ou senha incorretos', todo: validação de erros form login
        prefixIcon: Icon(
          Icons.lock_outline,
          size: 18,
          color: Color(0xff575c63),
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kGreenColor),
        ),
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? Icon(
                  Icons.visibility_off,
                  size: 18,
                )
              : Icon(
                  Icons.visibility,
                  size: 18,
                ),
          color: Color(0xff575c63),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        labelStyle: const TextStyle(
          color: Color(0xff575c63),
        ),
        focusColor: Color(0xff575c63),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    void _changeLanguage(Language language) async {
      //Locale _locale = await setLocale(language.languageCode);
      print(language.languageCode);
      setState(() {
        context.read<LanguageChangeProvider>().changeLocale(language.languageCode);      
      });
      //MyHomePage.setLocale(context, _locale);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Language>(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
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
      body: Stack(
        children: [
          Container(
            height: size.height - 200,
            color: kGreenColor,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logos/agrofate_logo_text.png",
                      fit: BoxFit.cover,
                      height: size.height * 0.07,
                      color: Colors.white,
                    ),
                    // Text(
                    //   'agrofate',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 40,
                    //     fontWeight: FontWeight.w900,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  S.of(context).telaLoginFrase,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildEmail(),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildPassword(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      S.of(context).telaLoginEsqueceuSenha,
                      style: TextStyle(
                        color: Color(0xff575c63),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                /*ButtonWidget(
                    title: 'ENTRAR',
                    hasBorder: false,
                    onClicked: () {                      
                      onClickedEntrar(emailController.text, password);
                      /*print('Email: ${emailController.text}');
                      print('Password: ${password}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreens()),
                      );*/
                    }),*/
                    
                Padding(                  
                  padding: const EdgeInsets.all(0.0),                        
                  child: new MaterialButton(
                    child: setUpButtonChild(),                    
                    onPressed: () {
                      setState(() {
                        if (_state == 0) {
                          onClickedEntrar(emailController.text, password);
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
                SizedBox(
                  height: 10,
                ),
                ButtonWidget(
                  title: S.of(context).telaLoginBotaoCadastrar,
                  hasBorder: true,
                  onClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: keyboardOpen ? 0.0 : size.height * 0.1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        S.of(context).telaLoginBotaoEntrar,
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