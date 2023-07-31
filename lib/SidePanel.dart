import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcx_live/screens/chat_screen/chat_screen.dart';
import 'package:mcx_live/screens/contact_us/Contact%20Us.dart';
import 'package:mcx_live/about.dart';

import 'screens/my_profile_screen.dart';

class SidePanelScreen extends StatefulWidget {
  const SidePanelScreen({Key? key}) : super(key: key);
  @override
  State<SidePanelScreen> createState() => _SidePanelScreenState();
}

class _SidePanelScreenState extends State<SidePanelScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'MCX',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          width: w,
          height: h,
          color: Colors.white,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Rahul Verma',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  'stoild@email.com',
                  style: GoogleFonts.lato(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      'images/User.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(),
                onDetailsPressed: () {
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
                  'Trade',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()));
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
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
                    fontSize: 20,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.blueAccent,
                  size: 35,
                ),
                title: Text(
                  'Settings',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContactScreen()),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutScreen()));
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
                            fontSize: 19,
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
              Image.asset('images/line chart.png')
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: Image.asset(
          "images/line chart.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
