import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcx_live/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../provider_classes/user_details_provider.dart';
import '../../utils/components/show_dialog.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({super.key});

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        Provider.of<UserProvider>(context, listen: false).getUser();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Refer & Earn',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'images/refer.png',
                    alignment: Alignment.center,
                    width: 280,
                    height: 245,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Earn Rs. 50',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ITF Rupee',
                  ),
                ),
                const SizedBox(height: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'One of your friends has joined by your referral code.Do more invitations to earn more.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 19,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Your Referral Code:',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userModel.referCode,
                            style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 50),
                      TextButton(
                        onPressed: () {
                          final val = ClipboardData(text: userModel.referCode);
                          Clipboard.setData(val);
                        },
                        child: const Text(
                          'Copy',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Share the Referral Code via',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: Container(
                    width: 230,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                        colors: <Color>[
                          Color(0xff12c1fc),
                          Color(0xff4171ff),
                          Color(0xff5459ff)
                        ],
                        stops: <double>[0, 0.589, 1],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Text(
                        'Share',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    await Share.share("launch https://mcx_live://");
                    //LaunchApp();
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
            child: Image.asset("images/line_chart.png", fit: BoxFit.fill)));
    ;
  }
}
