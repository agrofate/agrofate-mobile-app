import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
import 'package:agrofate_mobile_app/screens/forecast_screen.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../utilities/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xff575c63);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
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
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ForecastScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.cloud_outlined,
                color: MenuState.forecast == selectedMenu
                    ? kGreenColor
                    : inActiveIconColor,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => CanteirosScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.format_list_bulleted_outlined,
                color: MenuState.canteiros == selectedMenu
                    ? kGreenColor
                    : inActiveIconColor,
              ),
            ),
            IconButton(
              onPressed: () {}, // todo: NavigationPush pagina de dados
              icon: Icon(
                Icons.sensors_outlined,
                color: MenuState.dados == selectedMenu
                    ? kGreenColor
                    : inActiveIconColor,
              ),
            ),
            IconButton(
              onPressed: () {}, // todo: NavigationPush pagina de perfil
              icon: Icon(
                Icons.person_outline,
                color: MenuState.profile == selectedMenu
                    ? kGreenColor
                    : inActiveIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
