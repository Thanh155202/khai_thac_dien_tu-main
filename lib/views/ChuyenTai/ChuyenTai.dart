import 'package:flutter/material.dart';

class ChuyenTai extends StatefulWidget {
  const ChuyenTai({super.key});

  @override
  State<ChuyenTai> createState() => _ChuyenTaiState();
}

class _ChuyenTaiState extends State<ChuyenTai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Chuyển tải',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tàu chuyển tải: QNG-91119-TS",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Ngày chuyển tải: 1/12/2023",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Danh sách chuyển tải",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tên loài cá: Cá ngừ vây vàng",style: TextStyle(fontSize: 17),),
                            Text("Khối lượng chuyển tải: 1200kg",style: TextStyle(fontSize: 17),),
                            Text("Tàu nhận chuyển tải: QN-23824",style: TextStyle(fontSize: 17),),
                            Text("Thời gian chuyền tải: 19/23/00",style: TextStyle(fontSize: 17),),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

