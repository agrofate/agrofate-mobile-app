import 'package:agrofate_mobile_app/screens/forecast_screen.dart';
import 'package:agrofate_mobile_app/screens/main_screens.dart';
// import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreens()),
                          );
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
