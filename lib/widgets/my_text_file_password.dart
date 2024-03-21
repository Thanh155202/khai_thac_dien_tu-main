import 'package:flutter/material.dart';

class MyTextFieldpassword extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Image image;
  final EdgeInsets padding;


  MyTextFieldpassword({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.image,
    required bool obscureText,
    this.padding = const EdgeInsets.symmetric(horizontal: 40.0),
  }) : super(key: key);

  @override
  _MyTextFieldpasswordState createState() => _MyTextFieldpasswordState();
}

class _MyTextFieldpasswordState extends State<MyTextFieldpassword> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextField(
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: widget.image,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}


