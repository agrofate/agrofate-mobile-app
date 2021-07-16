import 'package:flutter/material.dart';

class ImageFieldWidget extends StatelessWidget {
  const ImageFieldWidget({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: const Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 53,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 14,
                ),
                Icon(
                  Icons.camera_alt_outlined,
                  size: 18,
                  color: Color(0xff575c63),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Insira uma imagem do canteiro",
                  style: TextStyle(
                    color: Color(0xff575c63),
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
