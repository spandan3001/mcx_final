import 'package:flutter/material.dart';
import 'package:mcx_live/utils/google_font.dart';
import '../../../utils/form_validator.dart';

Future<(bool, String)?> getRefInputDialog(BuildContext context,
    {required String title,
    required String text,
    VoidCallback? onPressed}) async {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return showDialog<(bool, String)>(
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
              FormValidationTextField(
                formKey: formKey,
                labelText: title,
                hintText: text,
                controller: controller,
              ),
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
              Navigator.of(context).pop((false, controller.text));
            },
          ),
          TextButton(
            child: const Text('Submit'),
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              }
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                Navigator.of(context).pop((true, controller.text));
              }
            },
          ),
        ],
      );
    },
  );
}
