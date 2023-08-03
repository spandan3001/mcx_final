import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudService {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference<Map<String, dynamic>> userCollection =
      db.collection("users");
  static CollectionReference<Map<String, dynamic>> paymentCollection =
      db.collection("payments");
  static CollectionReference<Map<String, dynamic>> messageCollection =
      db.collection("messages");
}
