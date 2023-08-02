import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          'Home',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: w,
        height: h,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 250),
            GestureDetector(
              child: Container(
                width: 320,
                height: 67,
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Requests',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 40),
            GestureDetector(
              child: Container(
                width: 320,
                height: 67,
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Update UPI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
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
      bottomNavigationBar: SizedBox(
        child: Image.asset(
          "images/line chart.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
