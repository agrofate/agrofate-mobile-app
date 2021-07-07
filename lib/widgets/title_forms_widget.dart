import 'package:flutter/material.dart';

class TitleFormsWidget extends StatelessWidget {
  const TitleFormsWidget({
    Key? key,
    required this.titleText,
  }) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
