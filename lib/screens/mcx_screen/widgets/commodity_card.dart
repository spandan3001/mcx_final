import 'package:flutter/material.dart';

import '../../../models/data_model.dart';
import '../../../utils/google_font.dart';

class CommodityCard extends StatefulWidget {
  const CommodityCard({super.key, required this.dataModel});

  final DataModel dataModel;

  @override
  State<CommodityCard> createState() => _CommodityCardState();
}

void test() {
  int oldX, newX;
  Color color;
  oldX = newX = 10;
  newX = getX();
  color = newX <= oldX ? color = Colors.red : Colors.green;
}

int getX() {
  return 20;
}

class _CommodityCardState extends State<CommodityCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: widget.dataModel.commodity.length * 15,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    widget.dataModel.commodity,
                    style: SafeGoogleFont(
                      'Sofia Pro',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff1d3a6f),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text("change"),
                        const Divider(
                          color: Colors.black,
                          height: 10,
                        ),
                        Text(widget.dataModel.chg),
                      ],
                    ),
                  ),
                  Container(
                    width: 70,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text("change%"),
                        const Divider(
                          color: Colors.black,
                          height: 10,
                        ),
                        Text(widget.dataModel.chgPercent),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text("open"),
                        Text(widget.dataModel.open),
                      ],
                    ),
                  ),
                  Container(
                    width: 70,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text("high"),
                        const Divider(
                          color: Colors.black,
                          height: 10,
                        ),
                        Text(widget.dataModel.high),
                      ],
                    ),
                  ),
                  Container(
                    width: 70,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text("low"),
                        const Divider(
                          color: Colors.black,
                          height: 10,
                        ),
                        Text(widget.dataModel.low),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: widget.dataModel.time.length * 15,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  widget.dataModel.time,
                  style: SafeGoogleFont(
                    'Sofia Pro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff1d3a6f),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
