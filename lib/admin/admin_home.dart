import 'package:flutter/material.dart';
import 'package:mcx_live/admin/platinum_screen.dart';
import 'package:mcx_live/admin/requests/add_request_screen.dart';
import 'package:mcx_live/admin/requests/withdraw_request_screen.dart';
import 'package:mcx_live/admin/total_profit_screen.dart';
import 'package:mcx_live/admin/update_upi/update_upi_screen.dart';
import 'package:mcx_live/admin/users_list_screen.dart';
import 'package:mcx_live/screens/chat_screen/model/message_model.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';
import 'custom_widgets/home_button.dart';
import 'history_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(height: 15),
              HomeButton(
                text: "Total Loss Profit",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TotalProfitScreen(),
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
                text: "Withdraw Requests",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WithdrawScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),
              HomeButton(
                text: "Payment Requests",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddScreen(),
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
              HomeButton(
                text: "Clear Chat",
                onPressed: () async {
                  final snapshot = await CloudService.messageCollection.get();
                  DateTime time =
                      DateTime.now().subtract(const Duration(days: 7));
                  snapshot.docs.map((e) {
                    MessageModel msg = MessageModel.fromSnapshot(e);
                    if (msg.timestamp.toDate().isBefore(time)) {
                      CloudService.messageCollection.doc(msg.id).delete();
                    }
                  });
                },
              ),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
