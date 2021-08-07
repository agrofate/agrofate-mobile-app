import 'package:agrofate_mobile_app/services/safra.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistorySafraScreen extends StatefulWidget {
  const HistorySafraScreen({Key key}) : super(key: key);

  @override
  _HistorySafraScreenState createState() => _HistorySafraScreenState();
}

class _HistorySafraScreenState extends State<HistorySafraScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      TitleFormsWidget(
                        titleText: 'Histórico de safras no \n' +
                            'Canteiro Sul', //TODO: recuperar nome do canteiro do BD
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
                            'Visualize o histórico de safras do seu canteiro.',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: historicoSafras.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        // TODO: abrir detalhes da safra antiga selecionada
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                historicoSafras[index].nome,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Plantação: " + historicoSafras[index].dataPlantacao,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Cultura: " + historicoSafras[index].cultura,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Divider(
                                thickness: 0.8,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Safra> historicoSafras = [
  Safra(
    nome: "Nome da safra 1",
    dataPlantacao: "26/06/21",
    cultura: "Couve",
  ),
  Safra(
    nome: "Nome da safra 2",
    dataPlantacao: "26/06/21",
    cultura: "Alface",
  ),
  Safra(
    nome: "Nome da safra 3",
    dataPlantacao: "26/06/21",
    cultura: "Couve",
  ),
  Safra(
    nome: "Nome da safra 4",
    dataPlantacao: "26/06/21",
    cultura: "Alface",
  ),
];
