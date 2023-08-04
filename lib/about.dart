import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'About',
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
      body: Container(
        width: w,
        height: h,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/trading.png",
                height: 170,
              ),
              const SizedBox(height: 20),
              const Text(
                'Meta Traders',
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
              const SizedBox(height: 28),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'App owner Address And So thin about',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.1,
        child: Image.asset(
          "images/line chart.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
