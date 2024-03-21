import 'package:flutter/material.dart';
import '../../models/boatModel.dart';
import '../../services/api_service.dart';
import '../../utils/widget_support.dart';

class QuanLiTau extends StatefulWidget {
  const QuanLiTau({super.key});

  @override
  _QuanLiTauState createState() => _QuanLiTauState();
}
class _QuanLiTauState extends State<QuanLiTau> {
  int selectedTrainIndex = -1;
  List<Boat> boatList = [];
  
  @override
  void initState() {
    super.initState();
    ApiService apiService = ApiService();
    apiService.fetchData((List<Boat> data) {
      setState(() {
        boatList = data;
        print(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'Thông tin tàu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: boatList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    color: const Color(0xFFFEEAE6),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'lib/assets/images/bg.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tàu ${boatList[index].soHieuTau}',
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.green),
                                onPressed: () {
                                  setState(() {
                                    selectedTrainIndex =
                                        (selectedTrainIndex == index)
                                            ? -1
                                            : index;
                                  });
                                },
                                child: Text(
                                  "Thông tin",
                                  style: AppWidget.buttonText(),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1),
                    height: selectedTrainIndex == index ? 500 : 0,
                    curve: Curves.easeInOut,
                    child: selectedTrainIndex == index
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text('Thuộc tính',style: TextStyle(fontWeight: FontWeight.bold),),),
                                DataColumn(label: Text('Thông tin',style: TextStyle(fontWeight: FontWeight.bold),),),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('Số hiệu tàu')),
                                  DataCell(Text(
                                      boatList[index].soHieuTau.toString())),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Thuyền trưởng')),
                                  DataCell(Text(boatList[index].thuyenTruong)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Loại thiết bị')),
                                  DataCell(Text(boatList[index].loaiThietBi)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Tên thiết bị')),
                                  DataCell(Text(boatList[index].tenThietBi)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Số imeil')),
                                  DataCell(Text(boatList[index].imo)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Số kẹp chì')),
                                  DataCell(Text(boatList[index].soKepChi)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Ngày niêm phong')),
                                  DataCell(Text(boatList[index].ngayNiemPhong)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Ngày đăng kí")),
                                  DataCell(Text(boatList[index].ngayDangKi))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Ngày hết hạn đăng kí")),
                                  DataCell(Text(boatList[index].ngayHetHanDangKy))
                                ]),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
