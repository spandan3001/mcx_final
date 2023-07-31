import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mcx_live/utils/round_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/components/show_dialog.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  void launchWhatsapp({required String number, required String message}) async {
    var androidUrl = "whatsapp://send?phone=$number&text=$message";
    var iosUrl = "https://wa.me/$number?text=${Uri.parse(message)}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception catch (ex) {
      showAlertDialog(context,
          text: "Error occurred,please install whatsapp.", title: "error");
    }
  }

  void phoneCall({required String number, required String message}) async {
    var url = Uri.parse("tel:$number");
    try {
      await launchUrl(url);
    } on Exception catch (ex) {
      showAlertDialog(context, text: "Error occurred.", title: "error");
    }
  }

  void launchMail({required String mailId, required String message}) async {
    var url = Uri.parse("mailto:$mailId");
    try {
      await launchUrl(url);
    } on Exception catch (ex) {
      showAlertDialog(context, text: "Error occurred.", title: "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              Center(
                child: Image.asset(
                  'images/User.png',
                  alignment: Alignment.center,
                  width: 250,
                  height: 170,
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  'Rahul Verma',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 47),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'E-mail',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'stoild@email.com',
                    hintStyle:
                        const TextStyle(color: Colors.black, fontSize: 19),
                    suffixIcon: SizedBox(
                      child: IconButton(
                          onPressed: () {
                            launchMail(
                                mailId: "spandanchintu222@gmail.com",
                                message: "hello customer here here");
                          },
                          icon:
                              Image.asset("images/mail.png", fit: BoxFit.fill)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'stoild@email.com',
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 19),
                      suffixIcon: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                phoneCall(
                                    number: "+917204460288",
                                    message: "hello customer here here");
                              },
                              icon: Image.asset(
                                "images/telephone.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                launchWhatsapp(
                                    number: "+917204460288",
                                    message: "hello customer here here");
                              },
                              icon: Image.asset(
                                "images/whatsapp1.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Address',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter Owner Address',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          child: Image.asset(
            "images/line chart.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
