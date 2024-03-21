
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../utils/constants.dart';
import '../../widgets/myButton.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/my_text_file_password.dart';
import '../TrangChu/home_mobile_screen.dart';



class MobileLoginLayout extends StatefulWidget {
  const MobileLoginLayout({super.key});

  @override
  State<MobileLoginLayout> createState() => _MobileLoginLayoutState();
}

class _MobileLoginLayoutState extends State<MobileLoginLayout> {
  bool isChecked = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> login() async {
    if (!usernameController.text.isEmpty && !passwordController.text.isEmpty) {
      var response = await http.post(Uri.parse("https://nhatkydientu.vn/mobile-api/login/"),
          body: jsonEncode({
            'username': usernameController.text,
            'password': passwordController.text,

          }));
      if(response.statusCode==200){
        print(response.statusCode);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Sai tài khoản hoặc mật khẩu"),
        ));
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Hãy nhập đầy đủ thông tin"),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Logo
                  SizedBox(
                    height: screenSize.height * 0.09,
                  ),
                  Image.asset(
                    'lib/assets/images/img_contact.png',
                    width: screenSize.width * 0.42,
                    height: screenSize.height * 0.17,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  const Text(
                    "Đăng nhập!",
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w800,
                      color: bigTextColor,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.1,
                  ),
                  MyTextField(
                    controller: usernameController,
                    hintText: "Nhập tài khoản",
                    obscureText: false,
                    image: Image.asset(
                      'lib/assets/images/user.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  MyTextFieldpassword(
                    controller: passwordController,
                    hintText: "Nhập mật khẩu",
                    obscureText: true,
                    image: Image.asset(
                      'lib/assets/images/lock.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  MyButton(
                    onTap: () {
                      login();
                      // login(usernameController.text.toString(),passwordController.text.toString());
                    },
                    color: buttonColor,
                    text: "Đăng nhập",
                    width: 150,
                    height: 40,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Secular One',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.13,
                  ),
                  const Text(
                    "Copyright © 2024 ",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                  const Text(
                    "Công ty TNHH Công nghệ SmartRF Việt Nam",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
