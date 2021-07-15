import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: ButtonWidget(
              title: 'NOVO CANTEIRO',
              hasBorder: true,
              onClicked: () {
                // todo: linkar nova tela de adc novo canteiro
                print("tela de adc novo canteiro");
              },
            ),
          ),
        ],
      ),
    );
  }
}
