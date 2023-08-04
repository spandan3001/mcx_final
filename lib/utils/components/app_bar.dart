import 'package:flutter/material.dart';

import '../google_font.dart';

AppBar appBar({required String title, required VoidCallback onTap}) {
  return AppBar(
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: SafeGoogleFont(
        'Poppins',
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    centerTitle: true,
    leading: GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.arrow_back_outlined,
        color: Colors.black,
      ),
    ),
  );
}
