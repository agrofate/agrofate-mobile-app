import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixIcondata; // pode ser nulo por conta da ?
  final bool obscureText;
  final Function? onChanged;
  final TextInputType? textInputType;
  final TextEditingController? textFieldController;

  const TextFieldWidget({
    required this.hintText,
    required this.prefixIconData,
    this.suffixIcondata,
    required this.obscureText,
    this.onChanged,
    this.textInputType,
    this.textFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFieldController,
      keyboardType: textInputType,
      textInputAction: TextInputAction.done,
      // onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyle(
        color: Color(0xff575c63),
        fontSize: 14.0,
      ),
      cursorColor: Color(0xff575c63),
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Color(0xff575c63),
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kGreenColor),
        ),
        suffixIcon: Icon(
          suffixIcondata,
          size: 18,
          color: Color(0xff575c63),
        ),
        labelStyle: const TextStyle(
          color: Color(0xff575c63),
        ),
        focusColor: Color(0xff575c63),
      ),
    );
  }
}
