import 'package:flutter/material.dart';
import 'package:kahel/constants/colors.dart';
import 'notification_container.dart';


class NotifModal {
  final String uid;

  NotifModal({required this.uid});

  build(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.topCenter,
            insetPadding: const EdgeInsets.all(8.0),
            content: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: const BoxDecoration(
                color: ColorPalette.accentWhite,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Notifications",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ColorPalette.accentBlack,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: ColorPalette.accentBlack,
                          size: 24, // Adjust the size as needed
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(child: NotificationContainer(uid: uid))
                ],
              ),
            ),
          );
        });
  }
}
