import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/provider_classes/admin_details_provider.dart';
import 'package:mcx_live/provider_classes/user_details_provider.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:provider/provider.dart';
import '../screens/home_screen/home_screen.dart';
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
  Future<AdminModel> getAdmin(email) async {
    final snapshot = await CloudService.adminCollection
        .where("email", isEqualTo: email)
        .get();
    return snapshot.docs.map((e) => AdminModel.fromSnapshot(e)).single;
  }

  void setAdminData(AdminModel? adminModel, BuildContext context) {
    if (adminModel != null) {
      Provider.of<AdminProvider>(context, listen: false).setAdmin(adminModel);
    } else {
      CloudService.adminCollection
          .get()
          .then((value) =>
              value.docs.map((e) => AdminModel.fromSnapshot(e)).single)
          .then((adminModel) {
        Provider.of<AdminProvider>(context, listen: false).setAdmin(adminModel);
      });
    }
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
                AdminModel adminModel = snapshotAdmin.data!;
                setAdminData(adminModel, context);
                return const SidePanelScreen(
                  isAdmin: true,
                );
              } else {
                setAdminData(null, context);
                return StreamBuilder(
                  stream: CloudService.userCollection
                      .where("email", isEqualTo: email)
                      .snapshots(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasData) {
                      if (userSnapshot.data!.size != 0) {
                        UserModel userModel = userSnapshot.data!.docs
                            .map((e) => UserModel.fromSnapshot(e))
                            .single;
                        Provider.of<UserProvider>(
                          context,
                          listen: false,
                        ).setUser(userModel);
                        return const SidePanelScreen(
                          isAdmin: false,
                        );
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
}
