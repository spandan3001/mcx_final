import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mcx_live/provider_classes/admin_details_provider.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/utils/color_constants.dart';
import 'package:mcx_live/utils/text_style.dart';
import 'package:provider/provider.dart';
import '../../utils/components/app_bar.dart';
import '../../utils/form_validator.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUpiScreen extends StatefulWidget {
  const UpdateUpiScreen({super.key});

  @override
  State<UpdateUpiScreen> createState() => _UpdateUpiScreenState();
}

class _UpdateUpiScreenState extends State<UpdateUpiScreen> {
  final _formKey = GlobalKey<FormState>();
  File? selectedImage;
  String? upiId;
  TextEditingController controller = TextEditingController();
  String getAdminDocId() =>
      Provider.of<AdminProvider>(context, listen: false).getAdminDocId();

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
        appBar: appBar(
          title: "UPDATE UPI",
          onTap: () {
            Navigator.pop(context);
          },
        ),
        bottomNavigationBar: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
            child: Image.asset("images/line_chart.png", fit: BoxFit.fill)),
        body: StreamBuilder(
            stream:
                CloudService.adminCollection.doc(getAdminDocId()).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                upiId = snapshot.data!.data()?['upiId'];
              }
              return Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image bim
                      Image.asset(
                        'images/bmi.png',
                        width: 170,
                        height: 50,
                      ),
                      const SizedBox(height: 30),
                      if (snapshot.hasData)
                        Text(
                          "Current UPI ID is: $upiId",
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      const SizedBox(height: 20),
                      //input box
                      FormValidationTextField(
                        formKey: _formKey,
                        labelText: "UPI ID",
                        hintText: "please enter the upi id",
                        controller: controller,
                      ),
                      const SizedBox(height: 30),
                      // upload scanner
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: kBorderColor),
                          color: kWhite,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upload Scanner',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: IconButton(
                                onPressed: () async {
                                  await pickImage();
                                },
                                icon: Image.asset(
                                  'images/upload.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (selectedImage != null)
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedImage = null;
                              });
                            },
                          ),
                        ),
                      if (selectedImage != null) Image.file(selectedImage!),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await updateUpi();
                            if (selectedImage != null) {
                              CloudStorage.upload(
                                  selectedImage!, "scanner.jpg");
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 160,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              begin: Alignment(1, 1),
                              end: Alignment(-1, -1),
                              colors: [kGradient1, kGradient2, kGradient3],
                              stops: <double>[0, 1, 2],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Update',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: kWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
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

  Future<void> updateUpi() async {
    await CloudService.adminCollection
        .doc(getAdminDocId())
        .update({"upiId": controller.text});
  }
}
