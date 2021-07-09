import 'package:agrofate_mobile_app/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../utilities/enums.dart';

class CanteirosScreen extends StatefulWidget {
  const CanteirosScreen({Key? key}) : super(key: key);

  @override
  _CanteirosScreenState createState() => _CanteirosScreenState();
}

class _CanteirosScreenState extends State<CanteirosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.canteiros),
    );
  }
}
