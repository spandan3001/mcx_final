import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcx_live/provider_classes/user_details_provider.dart';
import 'package:mcx_live/utils/components/app_bar.dart';
import 'package:mcx_live/utils/components/show_dialog.dart';
import 'package:mcx_live/utils/enums/gender_enum.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../services/firestore_services.dart';
import '../../ui_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final TextEditingController firstNameController;
  late final TextEditingController numberController;
  late final TextEditingController genderController;
  late final TextEditingController secondNameController;

  File? selectedImage;
  final double clipRadius = 70;

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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
          body: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              UserModel userModel = userProvider.getUser();
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: userModel.imageUrl == null
                          ? Image.asset(
                              'images/User.png',
                              alignment: Alignment.center,
                              width: 100,
                              height: 100,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(clipRadius),
                              child: Image.network(
                                userModel.imageUrl!,
                                fit: BoxFit.cover,
                                width: clipRadius * 2,
                                height: clipRadius * 2,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
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
                          TaskSnapshot? taskSnapshot =
                              await CloudStorage.upload(
                                  selectedImage!, "/users/${userModel.id}.jpg");

                          await taskSnapshot?.ref
                              .getDownloadURL()
                              .then((value) {
                            userProvider.updateDB({"imageUrl": value});
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: w / 3,
                                child: TextFormField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    hintText: userModel.firstName,
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 19),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Last Name',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: w / 3,
                                child: TextFormField(
                                  controller: secondNameController,
                                  decoration: InputDecoration(
                                    hintText: userModel.secondName,
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 19),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                          userModel.email,
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
                            hintText: userModel.number,
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
                          onPressed: () {
                            showAlertDialog(
                              context,
                              text: "are you sure?.\nData will be updated",
                              title: "Confirm",
                              onPressed: () {
                                userProvider.setUserToDB(
                                  UserModel(
                                      id: userModel.id,
                                      gender: Gender.others.name,
                                      number: numberController.text.isNotEmpty
                                          ? numberController.text
                                          : userModel.number,
                                      firstName:
                                          firstNameController.text.isNotEmpty
                                              ? firstNameController.text
                                              : userModel.firstName,
                                      secondName:
                                          secondNameController.text.isNotEmpty
                                              ? secondNameController.text
                                              : userModel.secondName,
                                      email: userModel.email,
                                      wallet: userModel.wallet,
                                      referCode: userModel.referCode,
                                      refererUId: userModel.refererUId),
                                );
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                  firstNameController.clear();
                                  secondNameController.clear();
                                  genderController.clear();
                                  numberController.clear();
                                }
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }
}
