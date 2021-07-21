import 'package:agrofate_mobile_app/screens/detail_canteiro_screen.dart';
import 'package:agrofate_mobile_app/services/canteiro.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'new_canteiro_screen.dart';

class CanteirosScreen extends StatefulWidget {
  const CanteirosScreen({Key? key}) : super(key: key);

  @override
  _CanteirosScreenState createState() => _CanteirosScreenState();
}

class _CanteirosScreenState extends State<CanteirosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        title: const Text(
          'Seus canteiros',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Em desenvolvimento')));
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: canteiros.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // TODO: enviar para página de detalhes do canteiro selecionado
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailCanteiroScreen(),
                            ),
                          );
                        },
                        child: Container(
                          // decoration:
                          //     const BoxDecoration(color: Colors.black12),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        // todo: trocar img do canteiro de acordo com banco - se tiver
                                        image: AssetImage(
                                            "assets/images/canteiro_padrao.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        canteiros[index].nomeCanteiro,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      Text(
                                        "Criação: " +
                                            canteiros[index].dataCriacao,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      Text(
                                        "Última atualização: " +
                                            canteiros[index]
                                                .dataUltimaAtualizacao,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 75, top: 6),
                                child: Divider(
                                  thickness: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ButtonWidget(
                    title: 'NOVO CANTEIRO',
                    hasBorder: true,
                    onClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewCanteiroScreen(),
                        ),
                      );
                    },
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

List<Canteiro> canteiros = [
  Canteiro(
    nomeCanteiro: "Canteiro Sul",
    dataCriacao: "26/06/21",
    dataUltimaAtualizacao: "27/06/21",
  ),
  Canteiro(
    nomeCanteiro: "Canteiro Norte",
    dataCriacao: "26/06/21",
    dataUltimaAtualizacao: "27/06/21",
  ),
  Canteiro(
    nomeCanteiro: "Canteiro Sul",
    dataCriacao: "26/06/21",
    dataUltimaAtualizacao: "27/06/21",
  ),
  Canteiro(
    nomeCanteiro: "Canteiro Norte",
    dataCriacao: "26/06/21",
    dataUltimaAtualizacao: "27/06/21",
  ),
];
