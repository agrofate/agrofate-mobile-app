import 'package:agrofate_mobile_app/screens/edit_canteiro_screen.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailCanteiroScreen extends StatefulWidget {
  const DetailCanteiroScreen({Key? key}) : super(key: key);

  @override
  _DetailCanteiroScreenState createState() => _DetailCanteiroScreenState();
}

class _DetailCanteiroScreenState extends State<DetailCanteiroScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              // TODO: enviar com informações do canteiro para editar
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCanteiroScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: (size.height) * 0.33,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/canteiro_padrao.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: -15.0,
                      offset: Offset(0, -15),
                      blurRadius: 40.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Canteiro Sul", // TODO: nome do canteiro
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              //TODO: adicionar lógica de safra ativa ou inativa para exibir botão de nova safra e histórico
              visible: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Adicione uma nova safra",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                      title: 'NOVA SAFRA',
                      hasBorder: false,
                      onClicked: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonWidget(
                      title: 'HISTÓRICO DE SAFRAS',
                      hasBorder: true,
                      onClicked:
                          false //TODO: recuperar informação se existe histórico de safras
                              ? () {}
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Não existe histórico de safras! Crie uma nova safra.')));
                                },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
