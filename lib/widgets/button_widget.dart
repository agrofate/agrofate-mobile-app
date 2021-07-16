import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final VoidCallback? onClicked;

  const ButtonWidget({
    required this.title,
    required this.hasBorder,
    this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? Colors.transparent : kGreenColor,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(
                  color: kGreenColor,
                  width: 1,
                )
              : const Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          onTap: onClicked,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: hasBorder ? kGreenColor : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
