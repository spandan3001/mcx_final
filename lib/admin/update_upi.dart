import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/color_constants.dart';

class UpdateUPI extends StatefulWidget {
  const UpdateUPI({super.key});

  @override
  State<UpdateUPI> createState() => _UpdateUPIState();
}

class _UpdateUPIState extends State<UpdateUPI> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void updateUpi() {
    _db
        .collection("adminUpi")
        .doc("upi_doc")
        .update({"upi_id": _controller.value.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16171D),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF16171D),
        title: const Text(
          'Update UPI',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Admin Upi is :-",
              softWrap: true,
              style: TextStyle(
                  color: kPrimaryYellowColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            StreamBuilder(
                stream: _db.collection("adminUpi").doc("upi_doc").snapshots(),
                builder: (context, snapshot) {
                  var data = snapshot.data?.data();
                  return Text(
                    data?['upi_id'] ?? " ",
                    softWrap: true,
                    style: const TextStyle(
                        color: kPrimaryYellowColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  );
                }),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                  hintText: 'Enter new UPI',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 22),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 23),
                cursorColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 260,
              height: 68,
              child: Padding(
                padding: const EdgeInsets.only(top: 7),
                child: ElevatedButton(
                  onPressed: () {
                    updateUpi();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5C249),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Color(0xFF16171D),
                      fontSize: 27,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
