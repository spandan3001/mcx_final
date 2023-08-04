import 'package:flutter/material.dart';
import 'package:mcx_live/utils/google_font.dart';

Future<bool?> showDialogReturn(BuildContext context,
    {required String text,
    required String title,
    VoidCallback? onPressed}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: SafeGoogleFont(
            'Poppins',
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              }
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              }
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
