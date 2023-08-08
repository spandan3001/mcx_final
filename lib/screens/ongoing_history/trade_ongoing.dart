import 'package:flutter/material.dart';

class TradeOngoing extends StatefulWidget {
  const TradeOngoing({super.key});

  @override
  State<TradeOngoing> createState() => _TradeOngoingState();
}

class _TradeOngoingState extends State<TradeOngoing> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Text("ongoing"),
    );
  }
}
