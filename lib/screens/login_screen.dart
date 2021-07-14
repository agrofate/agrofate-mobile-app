import 'package:agrofate_mobile_app/screens/main_screens.dart';
import 'package:agrofate_mobile_app/screens/register_screen.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
// import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/wave_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  String password = '';
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
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
        labelText: 'Senha',
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

    return Scaffold(
      backgroundColor: Colors.white,
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
            padding: const EdgeInsets.only(top: 110),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'agrofate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
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
                      'Esqueceu a senha?',
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
                ButtonWidget(
                    title: 'ENTRAR',
                    hasBorder: false,
                    onClicked: () {
                      print('Email: ${emailController.text}');
                      print('Password: ${password}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreens()),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                ButtonWidget(
                  title: 'CADASTRAR',
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
}
