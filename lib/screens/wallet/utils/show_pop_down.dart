import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mcx_live/provider_classes/admin_details_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/admin_model.dart';

class ShowPopDownButton extends StatefulWidget {
  const ShowPopDownButton({Key? key}) : super(key: key);

  @override
  State<ShowPopDownButton> createState() => _ShowPopDownButtonState();
}

class _ShowPopDownButtonState extends State<ShowPopDownButton> {
  dynamic getDetails(String key) {}

  _saveNetworkImage(String url) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "scanner");
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    AdminModel adminModelProvider =
        Provider.of<AdminProvider>(context, listen: false).getAdmin();
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 5),
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //a circular bordered box for the pop down menu
                    Container(
                      height: 6,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "UPI ID:-${adminModelProvider.upiId}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        TextButton(
                          onPressed: () {
                            final val = ClipboardData(
                                text: "${adminModelProvider.upiId}");
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
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        _saveNetworkImage(adminModelProvider.imageUrl!);
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
              );
            });
      },
      child: Center(
        child: Text(
          "upi details",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: getDetails('textColor'),
          ),
        ),
      ),
    );
  }
}
