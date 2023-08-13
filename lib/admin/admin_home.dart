import 'package:flutter/material.dart';
import 'package:mcx_live/admin/platinum_screen.dart';
import 'package:mcx_live/admin/update_upi/update_upi_screen.dart';
import 'package:mcx_live/admin/users_list_screen.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';
import 'add_remove.dart';
import 'custom_widgets/home_button.dart';
import 'history_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(
            title: "HOME",
            onTap: () {
              Navigator.pop(context);
            }),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 45),
                HomeButton(
                  text: "Total Profit",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlatinumScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 35),
                HomeButton(
                  text: "Platinum",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlatinumScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 35),
                HomeButton(
                  text: "Users",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UsersListScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 35),
                HomeButton(
                  text: "Requests",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddRemoveScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 35),
                HomeButton(
                  text: "Update UPI",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateUpiScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 35),
                HomeButton(
                  text: "Approved",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
