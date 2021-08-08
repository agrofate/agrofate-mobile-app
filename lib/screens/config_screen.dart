import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../LanguageChangeProvider.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key key}) : super(key: key);

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void _changeLanguage(Language language) async {
      //Locale _locale = await setLocale(language.languageCode);
      print(language.languageCode);
      setState(() {
        context
            .read<LanguageChangeProvider>()
            .changeLocale(language.languageCode);
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
      body: SingleChildScrollView(
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
                            titleText: S.of(context).telaConfigTitle,
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
                        descriptionText: S.of(context).telaConfigDescricao,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),

                  // Alterar e-mail
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.email_outlined,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              Text(
                                "Alterar e-mail",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Divider(
                              thickness: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Alterar senha
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.lock_outlined,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              Text(
                                "Alterar senha",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Divider(
                              thickness: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Sobre a agrofate
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.info_outline,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              Text(
                                "Sobre a agrofate",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Divider(
                              thickness: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Políticas de privacidade
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.policy_outlined,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              Text(
                                "Políticas de privacidade",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Divider(
                              thickness: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Sair
                  GestureDetector(
                    onTap: () {
                      // TODO: Logout function
                    },
                    child: Container(
                      width: size.width,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.logout_outlined,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              Text(
                                "Sair",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Divider(
                              thickness: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
