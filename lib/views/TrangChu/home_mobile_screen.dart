import 'package:flutter/material.dart';
import '../../widgets/PoliMap.dart';
import '../LienHe/LienHe.dart';
import '../Login/login_mobile_screen.dart';
import '../NhatKiKhaiThac/NhatKiKhaiThac.dart';
import '../QuanLiTau/QuanLiTau.dart';
import '../TheoDoiHaiTrinh/TheoDoiHaiTrinh.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    PolylineMap(),
    PolylineMap(),
    PolylineMap(),
    PolylineMap(),
    PolylineMap(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Bản đồ", style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('lib/assets/images/avatar.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Nguyễn Văn Thành",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/bg.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Tàu quản lí',style: TextStyle(color: Colors.black),),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuanLiTau()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/book.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Theo dõi hải trình',style: TextStyle(color: Colors.black)),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TheoDoiHaiTrinh(tenTau: 'tau1')),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/writing.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Nhật kí khai thác',style: TextStyle(color: Colors.black)),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NhatKi()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/contact.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Liên hệ',style: TextStyle(color: Colors.black)),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LienHe()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/logout.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Đăng xuất',style: TextStyle(color: Colors.black)),
              selected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MobileLoginLayout()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
