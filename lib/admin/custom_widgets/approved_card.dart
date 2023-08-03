import 'package:flutter/material.dart';

class ApprovedCardWidget extends StatelessWidget {
  const ApprovedCardWidget(
      {super.key,
      required this.slNo,
      required this.refNo,
      required this.name,
      required this.email,
      required this.docId,
      required this.userId,
      required this.approvedDays});

  final int slNo;
  final String refNo;
  final String name;
  final String email;
  final String docId;
  final String userId;
  final int approvedDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5C249),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "$slNo",
                        style: const TextStyle(
                          color: Color(0xFF16171D),
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    refNo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(width: 36),
                      Expanded(
                        child: Text(
                          name,
                          softWrap: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Text(
                          email,
                          softWrap: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 37),
            ],
          ),
        ),
      ),
    );
  }
}
