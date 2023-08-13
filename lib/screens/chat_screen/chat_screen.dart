import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:provider/provider.dart';
import '../../provider_classes/user_details_provider.dart';
import '../../services/code_generator.dart';
import '../../utils/components/show_dialog.dart';
import '../../utils/google_font.dart';
import 'input_box.dart';
import 'message_stream.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';

  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  late String textMessage;

  String? imageUrl;

  File? selectedImage;

  //final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  _saveNetworkImage(String url) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "scanner");
    print(result);
  }

  void updateImage() async {
    if (selectedImage != null) {
      TaskSnapshot? taskSnapshot = await CloudStorage.upload(
          selectedImage!, "${CodeGenerator.generateCode()}.jpg");
      imageUrl = await taskSnapshot?.ref.getDownloadURL();
      setState(() {});
    } else {
      showAlertDialog(context, text: "something went wrong", title: "status");
    }
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<UserProvider>(context, listen: false).getEmail();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'CHAT',
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MessageStream(
              stream: CloudService.messageCollection
                  .orderBy("timeStamp", descending: true)
                  .snapshots(),
            ),
            if (selectedImage != null)
              SizedBox(
                  height: 100,
                  child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  )),
            InputMessage(
              controller: messageController,
              onPressed: () {
                textMessage = messageController.text;
                if (textMessage.trim().isNotEmpty) {
                  if (selectedImage != null) updateImage();
                  CloudService.messageCollection.add({
                    'sender': email,
                    "text": textMessage,
                    "timeStamp": FieldValue.serverTimestamp(),
                    "imageUrl": imageUrl
                  });
                  setState(() {
                    selectedImage = null;
                    messageController.clear();
                  });
                }
              },
              onPressedForImage: () async {
                await pickImage();
              },
            )
          ],
        ),
      ),
    );
  }
}
