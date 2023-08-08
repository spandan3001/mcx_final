import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mcx_live/archieve/web_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/enums/mcx_code.dart';
import '../mcx_services/mcx_data_service.dart';

class MCX extends StatefulWidget {
  const MCX({super.key});

  @override
  State<MCX> createState() => _MCXState();
}

class _MCXState extends State<MCX> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {},
          child: const Text("press"),
        ),
      ),
    );
  }
}
