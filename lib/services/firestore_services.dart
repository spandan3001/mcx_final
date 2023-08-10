import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudService {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference<Map<String, dynamic>> userCollection =
      db.collection("users");
  static CollectionReference<Map<String, dynamic>> adminCollection =
      db.collection("admin");
  static CollectionReference<Map<String, dynamic>> paymentCollection =
      db.collection("payments");
  static CollectionReference<Map<String, dynamic>> messageCollection =
      db.collection("messages");
  static CollectionReference<Map<String, dynamic>> mcxCollection =
      db.collection("mcx");
  static CollectionReference<Map<String, dynamic>> orderCollection =
      db.collection("orders");
}

class CloudStorage {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<TaskSnapshot?> upload(File file, String imgName) async {
    try {
      TaskSnapshot taskSnapshot =
          await storage.ref("images/$imgName").putFile(file);
      return taskSnapshot;
    } catch (ex) {
      print(ex);
    }
    return null;
  }
}
