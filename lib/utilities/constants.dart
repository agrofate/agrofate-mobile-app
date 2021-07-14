import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

const kGreenColor = Color(0xff4b9100);
const kGrayColor = Color(0xff575c63);

class Global {
  static const Color white = Color(0xffffffff);
}
