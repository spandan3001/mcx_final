import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/provider_classes/user_detials_provider.dart';
import 'package:provider/provider.dart';

import '../SidePanel.dart';
import '../home.dart';
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
                return Consumer<UserProvider>(
                  builder: (context, userProvider, child) => FutureBuilder(
                    future: getUser(email),
                    builder: (context, snapshot1) {
                      if (snapshot1.connectionState == ConnectionState.done) {
                        if (snapshot1.hasData) {
                          UserModel userModel = snapshot1.data as UserModel;
                          userProvider.setUser(userModel);
                          return const SidePanelScreen();
                        } else if (snapshot1.hasError) {
                          return Center(
                              child: Text(snapshot1.error.toString()));
                        } else {
                          return const Center(child: Text("Something wrong"));
                        }
                      } else {
                        return const Loading();
                      }
                    },
                  ),
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
