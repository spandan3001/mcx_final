import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mcx_live/models/admin_model.dart';
import 'package:mcx_live/provider_classes/admin_details_provider.dart';
import 'package:mcx_live/utils/components/app_bar.dart';
import 'package:mcx_live/utils/components/show_dialog.dart';
import 'package:provider/provider.dart';

import '../services/firestore_services.dart';
import '../ui_screen.dart';

class AdminUpdateScreen extends StatefulWidget {
  const AdminUpdateScreen({super.key});

  @override
  State<AdminUpdateScreen> createState() => _AdminUpdateScreenState();
}

class _AdminUpdateScreenState extends State<AdminUpdateScreen> {
  late final TextEditingController firstNameController;
  late final TextEditingController numberController;
  late final TextEditingController genderController;
  late final TextEditingController secondNameController;

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
    firstNameController = TextEditingController();
    secondNameController = TextEditingController();
    numberController = TextEditingController();
    genderController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(
            title: "PROFILE",
            onTap: () {
              Navigator.pop(context);
            }),
        body: Consumer<AdminProvider>(
          builder: (context, adminProvider, child) {
            AdminModel adminModel = adminProvider.getAdmin();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: adminModel.imageUrl == ""
                        ? Image.asset(
                            'images/User.png',
                            alignment: Alignment.center,
                            width: 100,
                            height: 100,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(clipRadius),
                            child: Image.network(
                              adminModel.imageUrl!,
                              fit: BoxFit.cover,
                              width: clipRadius * 2,
                              height: clipRadius * 2,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      await pickImage();
                      if (selectedImage != null) {
                        TaskSnapshot? taskSnapshot = await CloudStorage.upload(
                            selectedImage!, "/admin/${adminModel.id}.jpg");
                        await taskSnapshot?.ref.getDownloadURL().then((value) {
                          adminProvider.updateDB({"imageUrl": value});
                        });
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Change Photo',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'First Name',
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
                      controller: firstNameController,
                      decoration: InputDecoration(
                        hintText: adminModel.name,
                        hintStyle:
                            const TextStyle(color: Colors.black, fontSize: 19),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: 330,
                      child: Text(
                        adminModel.email,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
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
                    child: SizedBox(
                      width: 330,
                      child: TextFormField(
                        controller: numberController,
                        decoration: InputDecoration(
                          hintText: adminModel.number,
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 19),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: 330,
                      child: TextFormField(
                        controller: genderController,
                        decoration: const InputDecoration(
                          hintText: 'Male',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 19),
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
                            text: "are you sure?.\nData will be updated",
                            title: "Confirm",
                            onPressed: () {
                              adminProvider.setUserToDB(
                                AdminModel(
                                    id: adminModel.id,
                                    number: adminModel.id,
                                    name: adminModel.name,
                                    email: adminModel.email,
                                    upiId: adminModel.upiId),
                              );
                            },
                          ).then((value) {
                            firstNameController.clear();
                            secondNameController.clear();
                            genderController.clear();
                            numberController.clear();
                            return value;
                          });
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
              ),
            );
          },
        ),
      ),
    );
  }
}
