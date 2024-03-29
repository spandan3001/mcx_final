import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mcx_live/screens/wallet/utils/show_pop_down.dart';

Future<bool> _saveNetworkImage(String url) async {
  var response =
      await Dio().get(url, options: Options(responseType: ResponseType.bytes));
  final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: "scanner");
  return result['isSuccess'];
}

Future<(bool, String)?> getRefInputDialog(BuildContext context,
    {required String title,
    required String text,
    VoidCallback? onPressed}) async {
  return showDialog<(bool, String)>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return ShowScanner(
        text: text,
        title: title,
      );
    },
  );
}
