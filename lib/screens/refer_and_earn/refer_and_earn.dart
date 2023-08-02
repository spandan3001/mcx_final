import 'package:flutter/material.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({super.key});

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Refer & Earn',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: w,
          height: h,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'images/refer.png',
                  alignment: Alignment.center,
                  width: 280,
                  height: 245,
                ),
              ),
              SizedBox(height: 25),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Earn Rs. 50',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ITF Rupee',
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Expanded(
                          child: Text(
                            'One of your friends has joined by your referral code.Do more invitations to earn more.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 19,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: 350,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'Your Referral Code',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'STOILDPVTLTD',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 28,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 50),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Copy',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Text(
                'Share the Referral Code via',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 10),
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
                  child: Center(
                    child: Text(
                      'Share',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
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
    ;
  }
}
