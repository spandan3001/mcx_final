import 'package:flutter/material.dart';
import 'package:mcx_live/utils/google_font.dart';
import '../../../utils/form_validator.dart';

Future<bool?> getRefInputDialog(BuildContext context,
    {required String title,
    required TextEditingController controller,
    required,
    VoidCallback? onPressed}) async {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
              FormValidationTextField(
                formKey: formKey,
                labelText: "Ref ID",
                hintText: "please enter the reference id",
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
              Navigator.of(context).pop(false);
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
                Navigator.of(context).pop(true);
              }
            },
          ),
        ],
      );
    },
  );
}
