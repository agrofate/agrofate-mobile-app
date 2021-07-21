import 'package:flutter/material.dart';

class NotificationDadosWidget extends StatelessWidget {
  const NotificationDadosWidget({
    Key? key,
    required this.colorNotification,
    required this.message,
    required this.iconNotification,
  }) : super(key: key);

  final int colorNotification;
  final String message;
  final IconData iconNotification;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Color(colorNotification).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      // Icons.warning,
                      iconNotification,
                      size: 30,
                      color: Color(colorNotification).withOpacity(0.8),
                    )
                  ],
                ),
                Container(
                  width: (MediaQuery.of(context).size.width * 0.9) - 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Wrap(
                        children: [
                          Text(
                            message,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(colorNotification).withOpacity(0.8),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
