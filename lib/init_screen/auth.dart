import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/provider_classes/user_detials_provider.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen/home_screen.dart';
import '../admin_home.dart';
import '../login_register/login_or_register.dart';
import '../models/admin_model.dart';
import '../models/user_model.dart';
import '../utils/components/circular_progress.dart';

class MyAuth extends StatefulWidget {
  const MyAuth({super.key});

  @override
  State<MyAuth> createState() => _MyAuthState();
}

class _MyAuthState extends State<MyAuth> {
  final _db = FirebaseFirestore.instance;

  Future<UserModel> getUser(email) async {
    final snapshot =
        await _db.collection("users").where("email", isEqualTo: email).get();
    return snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final FirebaseAuth auth = FirebaseAuth.instance;
          final User? user = auth.currentUser;
          final email = user?.email;
          return FutureBuilder(
            future: getAdmin(email),
            builder: (context, snapshotAdmin) {
              if (snapshotAdmin.hasData) {
                //AdminModel adminData = snapshotAdmin.data as AdminModel;
                return const HomeScreen();
              } else {
                return StreamBuilder(
                  stream: _db
                      .collection("users")
                      .where("email", isEqualTo: email)
                      .snapshots(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasData) {
                      if (userSnapshot.data!.size != 0) {
                        UserModel userModel = userSnapshot.data!.docs
                            .map((e) => UserModel.fromSnapshot(e))
                            .single;
                        Provider.of<UserProvider>(context, listen: false)
                            .setUser(userModel);
                        return const SidePanelScreen();
                      } else {
                        return const Loading();
                      }
                    } else if (userSnapshot.hasError) {
                      return Center(child: Text(userSnapshot.error.toString()));
                    } else {
                      return const Loading();
                    }
                  },
                );
              }
            },
          );
        } else {
          return const LoginOrRegister();
        }
      },
    );
  }

  Future<AdminModel> getAdmin(email) async {
    final snapshot =
        await _db.collection("admin").where("email", isEqualTo: email).get();
    return snapshot.docs.map((e) => AdminModel.fromSnapshot(e)).single;
  }
}
