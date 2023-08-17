import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mcx_live/provider_classes/admin_details_provider.dart';
import 'package:mcx_live/utils/color_constants.dart';
import 'package:provider/provider.dart';

import '../../../models/admin_model.dart';
import '../../../utils/form_validator.dart';
import '../../../utils/google_font.dart';

class ShowScanner extends StatefulWidget {
  const ShowScanner(
      {Key? key, required this.text, required this.title, this.onPressed})
      : super(key: key);
  final String text;
  final String title;
  final VoidCallback? onPressed;

  @override
  State<ShowScanner> createState() => _ShowScannerState();
}

class _ShowScannerState extends State<ShowScanner> {
  bool? status;

  Future<bool> _saveNetworkImage(String url) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "scanner");
    return result['isSuccess'];
  }

  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AdminModel adminModelProvider =
        Provider.of<AdminProvider>(context, listen: false).getAdmin();
    return AlertDialog(
      title: Text(
        widget.title,
        style: SafeGoogleFont(
          'Poppins',
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "UPI ID:-${adminModelProvider.upiId}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade100),
                  onPressed: () {
                    final val =
                        ClipboardData(text: "${adminModelProvider.upiId}");
                    Clipboard.setData(val);
                  },
                  child: const Text(
                    'Copy',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade100),
                  onPressed: () async {
                    status =
                        await _saveNetworkImage(adminModelProvider.imageUrl!);
                    setState(() {});
                  },
                  child: const Text(
                    'download',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (status != null)
              Text(
                status! ? "✅Success" : "❌Error",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: FormValidationTextField(
                    formKey: formKey,
                    labelText: widget.title,
                    hintText: widget.text,
                    controller: controller,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('No'),
          onPressed: () {
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
            Navigator.of(context).pop((false, controller.text));
          },
        ),
        TextButton(
          child: const Text('Submit'),
          onPressed: () {
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              Navigator.of(context).pop((true, controller.text));
            }
          },
        ),
      ],
    );
  }
}
