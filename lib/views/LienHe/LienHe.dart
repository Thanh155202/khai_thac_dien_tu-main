import 'package:flutter/material.dart';

class LienHe extends StatefulWidget {
  const LienHe({Key? key});

  @override
  State<LienHe> createState() => _LienHeState();
}

class _LienHeState extends State<LienHe> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        centerTitle: true,
        title:  Text(
          'Liên hệ',
          style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: screenSize.height*0.027),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.05),
                  child:  Text(
                    'NHÀ SẢN XUẤT VÀ PHÂN PHỐI',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.height*0.028,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            Flexible(
              flex: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/img_contact.png',
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    Text(
                      "Công ty TNHH Công nghệ SmartRF Việt Nam",
                      style: TextStyle(fontSize: screenSize.height*0.021,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center, // Center text
                    ),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    Text(
                      "Địa chỉ: 18 Hoàng Quốc Việt, Nghĩa Đô",
                      style: TextStyle(fontSize: screenSize.height*0.018),
                      textAlign: TextAlign.center, // Center text
                    ),
                    SizedBox(
                      height: screenSize.height * 0.004,
                    ),
                     Text(
                      "Cầu Giấy, Hà Nội ",
                      style: TextStyle(fontSize: screenSize.height*0.018),
                      textAlign: TextAlign.center, // Center text
                    ),
                    SizedBox(
                      height: screenSize.height * 0.028,
                    ),
                    Text(
                      "Hotline: 091356090",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: screenSize.height*0.021,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                          decorationThickness: 2.0,
                        decorationColor: Colors.blue
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.26,
                    ),
                     Text(
                      "Copyright © 2023",
                      style: TextStyle(fontSize: screenSize.height*0.019),
                      textAlign: TextAlign.center, // Center text
                    ),
                    Text(
                      "Công ty TNHH Công nghệ SmartRF Việt Nam",
                      style: TextStyle(fontSize: screenSize.height*0.019),
                      textAlign: TextAlign.center, // Center text
                    ),
                  ],
                ),
            ),
            ],
        ),
        ),
      );
  }
}
