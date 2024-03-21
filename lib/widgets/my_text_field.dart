import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Image image;
  final EdgeInsets padding;


  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.image,
    this.padding = const EdgeInsets.symmetric(horizontal: 40.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(

          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0), // Điều chỉnh lề của hình ảnh
            child: image, // Hình ảnh
          ),
        ),
      ),
    );
  }
}
