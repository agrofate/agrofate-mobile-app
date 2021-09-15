import 'package:flutter/material.dart';

class NotificationDadosWidget extends StatelessWidget {
  const NotificationDadosWidget({
    Key key,
    this.colorNotification,
    this.message,
    this.iconNotification,
  }) : super(key: key);

  final int colorNotification;
  final String message;
  final IconData iconNotification;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Color(colorNotification).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              // Icons.warning,
              iconNotification,
              size: 48,
              color: Color(colorNotification).withOpacity(0.9),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Recomendação",
              style: TextStyle(
                fontSize: 13,
                color: Color(colorNotification).withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            Wrap(
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(colorNotification).withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
