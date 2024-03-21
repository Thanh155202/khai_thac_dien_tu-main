import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle buttonText(){
    return TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto'
    );
  }

  static TextStyle bigText(){
    return TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto'
    );
  }
}