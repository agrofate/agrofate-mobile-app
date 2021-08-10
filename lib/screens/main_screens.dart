import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
import 'package:agrofate_mobile_app/screens/dados_screen.dart';
import 'package:agrofate_mobile_app/screens/forecast_screen.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';

class MainScreens extends StatefulWidget {
  
  final int myInt;
  MainScreens({Key key, this.myInt}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 0;

  @override
  void initState() { 
    super.initState();
    //set our varible state to be that of the parent screen
    //isMeeters is a local var to Settings and is changeable. 
    //isM is a static and can't be changed. isM was passed in 
    //from our home screen. We need a changeable var or the 
    //checkboxes won't update correctly. Thats why we need 
    //isMeeters (lol bad spelling). When the settings screen 
    //first loads we use initState to take the value of 
    //isM(from our home screen) and copy it into isMeeters 
    //as it's initial value before it is built and shown 
    //to the user for the first time. 
    isMeeters = widget.myInt;
  }
  
  var isMeeters;
  bool tela_anterior = false;
  @override
  Widget build(BuildContext context) {
    List<Widget> _telas = [
      ForecastScreen(),
      CanteirosScreen(),
      DadosScreen(),
      Text(S.of(context).telaPerfilDesenvolvimento),
    ];
    print(isMeeters);
    if(isMeeters != null){
      if(tela_anterior == false){
        _selectedIndex = isMeeters;
      }
    }

    void _onItemTap(int index) {
      tela_anterior = true;
      setState(() {
        _selectedIndex = index;
        print(_selectedIndex);
      });
    }

    return Scaffold(
      body: Center(
        child: _telas.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 15,
              color: const Color(0xFFDADADA).withOpacity(0.15),
            ),
          ],
          color: Colors.white,
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(40),
          //   topRight: Radius.circular(40),
          // ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kGreenColor,
          selectedFontSize: 12,
          unselectedItemColor: const Color(0xff575c63),
          unselectedFontSize: 12,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined),
              label: S.of(context).telaMainBotaoPrevisao,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined),
              label: S.of(context).telaMainBotaoCanteiro,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sensors_outlined),
              label: S.of(context).telaMainBotaoDados,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: S.of(context).telaMainBotaoPerfil,
            ),
          ],
        ),
      ),
    );
  }
}
