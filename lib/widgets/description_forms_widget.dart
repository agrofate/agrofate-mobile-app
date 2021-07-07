import 'package:flutter/material.dart';

class DescriptionFormsWidget extends StatelessWidget {
  const DescriptionFormsWidget({
    Key? key,
    required this.descriptionText,
  }) : super(key: key);

  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Text(
      descriptionText,
      style: const TextStyle(
        color: Color(0xff575c63),
        fontSize: 14,
      ),
    );
  }
}
