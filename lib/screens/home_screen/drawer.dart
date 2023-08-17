import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcx_live/admin/admin_home.dart';
import 'package:mcx_live/screens/ongoing_history/tab_screen.dart';
import 'package:mcx_live/screens/wallet/utils/enums.dart';
import 'package:provider/provider.dart';
import '../../about.dart';
import '../../models/user_model.dart';
import '../../provider_classes/user_details_provider.dart';
import '../chat_screen/chat_screen.dart';
import '../contact_us/contact_us_screen.dart';
import '../profile_screen/my_profile_screen.dart';
import '../refer_and_earn/faq.dart';
import '../refer_and_earn/pivacy.dart';
import '../refer_and_earn/refer_and_earn.dart';
import '../wallet/wallet_screen.dart';

Drawer drawer(BuildContext context, bool isAdmin) {
  return Drawer(
    child: Consumer<UserProvider>(builder: (context, userProvider, child) {
      UserModel userModel = userProvider.getUser();
      const double clipRadius = 70;
      return ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "${userModel.firstName} ${userModel.secondName}",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              userModel.email,
              style: GoogleFonts.lato(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            currentAccountPicture: Center(
              child: userModel.imageUrl == ""
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
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
            ),
            decoration: const BoxDecoration(),
            onDetailsPressed: () {
              Navigator.pop(context);
            },
          ),
          if (isAdmin)
            ListTile(
              leading: const Icon(
                Icons.home,
                size: 35,
                color: Colors.blue,
              ),
              title: Text(
                'Admin',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminHomeScreen()));
              },
            ),
          if (!isAdmin)
            ListTile(
              leading: const Icon(
                Icons.home,
                size: 35,
                color: Colors.blue,
              ),
              title: Text(
                'Home',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ListTile(
            leading: Image.asset(
              'images/trading.png',
              height: 35,
              width: 35,
              color: Colors.blue,
            ),
            title: Text(
              'My Trade',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TabScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'images/save-money.png',
              height: 35,
              width: 35,
              color: Colors.blue,
            ),
            title: Text(
              'Deposit',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WalletScreen(
                            type: TypeOfSubmit.add,
                          )));
            },
          ),
          ListTile(
            leading: Image.asset(
              'images/chat.png',
              height: 35,
              width: 35,
            ),
            title: Text(
              'Chat Room',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            },
          ),
          ListTile(
            leading: Image.asset(
              'images/withdraw.png',
              height: 35,
              width: 35,
              color: Colors.blue,
            ),
            title: Text(
              'Withdrawal',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WalletScreen(
                            type: TypeOfSubmit.withdraw,
                          )));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.contacts_outlined,
              color: Colors.blueAccent,
              size: 35,
            ),
            title: Text(
              'My Profile',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'images/contract.png',
              height: 35,
              width: 35,
              color: Colors.blue,
            ),
            title: Text(
              'Privacy Policy',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyScreen(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.settings,
          //     color: Colors.blueAccent,
          //     size: 35,
          //   ),
          //   title: Text(
          //     'Settings',
          //     style: GoogleFonts.lato(
          //       color: Colors.black,
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            leading: Image.asset(
              'images/contact.png',
              height: 35,
              width: 35,
              color: Colors.blue,
            ),
            title: Text(
              'Contact Us',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'images/promotion (1).png',
              height: 38,
              width: 38,
              color: Colors.blue,
            ),
            title: Text(
              'Refer and Earn',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReferEarn()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help_outline,
              color: Colors.blueAccent,
              size: 35,
            ),
            title: Text(
              'Helps & FAQs',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.blueAccent,
              size: 35,
            ),
            title: Text(
              'About',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
          ),
          const SizedBox(height: 19),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 88.0),
            child: GestureDetector(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                      size: 35,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Log Out',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
            child: Image.asset(
              "images/line_chart.png",
              fit: BoxFit.fill,
            ),
          )
        ],
      );
    }),
  );
}
