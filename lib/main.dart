import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sidepanel_flutter/SidePanel.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
      ),
      home: Sidepanel(),
    );
  }
}
