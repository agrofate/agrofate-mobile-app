import 'package:agrofate_mobile_app/screens/forecast_screen.dart';
// import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForecastScreen()),
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
