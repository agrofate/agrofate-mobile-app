import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
import 'package:agrofate_mobile_app/screens/dados_screen.dart';
import 'package:agrofate_mobile_app/screens/forecast_screen.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> _telas = [
      ForecastScreen(),
      CanteirosScreen(),
      DadosScreen(),
      Text('Em desenvolvimento'),
    ];

    void _onItemTap(int index) {
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined),
              label: 'Previsão',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined),
              label: 'Canteiros',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sensors_outlined),
              label: 'Dados',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
