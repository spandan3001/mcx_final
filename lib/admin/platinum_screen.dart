import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcx_live/utils/components/app_bar.dart';
import 'package:mcx_live/utils/components/circular_progress.dart';
import 'package:mcx_live/utils/components/show_dialog.dart';
import '../services/firestore_services.dart';
import '../ui_screen.dart';

class PlatinumScreen extends StatefulWidget {
  const PlatinumScreen({super.key});

  @override
  State<PlatinumScreen> createState() => _PlatinumScreenState();
}

class _PlatinumScreenState extends State<PlatinumScreen> {
  late final TextEditingController tokenController;
  late final TextEditingController buyController;
  late final TextEditingController sellController;

  File? selectedImage;

  final double clipRadius = 60;
  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tokenController = TextEditingController();
    buyController = TextEditingController();
    sellController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar(
              title: "PROFILE",
              onTap: () {
                Navigator.pop(context);
              }),
          body: SingleChildScrollView(
            child: StreamBuilder(
                stream: CloudService.platinumDoc.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data?.data();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.05),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Token',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: tokenController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: data?['token'] ?? "xxx",
                              hintStyle: const TextStyle(
                                  color: Colors.black, fontSize: 19),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Buy Points',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: buyController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: data?['buyPoint'] ?? "xxx",
                              hintStyle: const TextStyle(
                                  color: Colors.black, fontSize: 19),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'sell Points',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            child: TextFormField(
                              controller: sellController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                hintText: data?['sellPoint'] ?? "xxx",
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 19),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Center(
                          child: SizedBox(
                            width: 240,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () async {
                                await showAlertDialog(
                                  context,
                                  optionNo: true,
                                  text: "are you sure?.\ndata will be updated",
                                  title: "Confirm",
                                  onPressed: () {
                                    CloudService.platinumDoc.update(
                                      {
                                        "token": tokenController.text.isNotEmpty
                                            ? tokenController.text
                                            : data?['token'],
                                        "buyPoint":
                                            buyController.text.isNotEmpty
                                                ? buyController.text
                                                : data?['buyPoint'],
                                        "sellPoint":
                                            sellController.text.isNotEmpty
                                                ? sellController.text
                                                : data?['sellPoint']
                                      },
                                    );
                                  },
                                ).then(
                                  (value) {
                                    tokenController.clear();
                                    sellController.clear();
                                    buyController.clear();
                                    return value;
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Loading();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
