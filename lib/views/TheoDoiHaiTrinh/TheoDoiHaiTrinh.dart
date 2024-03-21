import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:originproject/widgets/shipHistory.dart';
import '../../models/boatModel.dart';
import '../../services/api_service.dart';
import '../../widgets/PoliMap.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/myButton.dart';
import 'dart:async'; // Import thư viện Timer
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';


class TheoDoiHaiTrinh extends StatefulWidget {
  final String tenTau;

  const TheoDoiHaiTrinh({Key? key, required this.tenTau}) : super(key: key);

  @override
  State<TheoDoiHaiTrinh> createState() => _TheoDoiHaiTrinhState();
}

class ShipHistoryEntry {
  final LatLng coordinate;
  final String time;

  ShipHistoryEntry({
    required this.coordinate,
    required this.time,
  });
}

class _TheoDoiHaiTrinhState extends State<TheoDoiHaiTrinh> {
  ApiService apiService = ApiService();
  List<Boat> listBoats = [];
  String selectedBoatSoHieuTau = ''; // Biến để lưu trữ tàu được chọn
  String selectedSoHieuTau = '';
  String selectedChuyenBien = '1';
  DateTime? _startDate1;
  DateTime? _startDate2;
  bool showShipHistory = false; // Biến kiểm soát hiển thị lịch sử tàu
  List<ShipHistoryEntry> shipHistory = []; // Khai báo biến shipHistory

  @override
  void initState() {
    super.initState();
    selectedBoatSoHieuTau = listBoats.isNotEmpty ? listBoats[0].soHieuTau : '';
    fetchData();
  }

  Future<void> fetchData() async {
    apiService.fetchData((List<Boat> boats) {
      setState(() {
        listBoats = boats;
        // Set the default selected boat if needed
        selectedBoatSoHieuTau =
            listBoats.isNotEmpty ? listBoats[0].soHieuTau : '';
      });
    });
  }

  Future<void> _selectStartDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale('vi', ''), // Tiếng Việt,
      // Thay đổi các lời nhắc sang tiếng Việt
      helpText: 'Chọn ngày',
      cancelText: 'Hủy',
      confirmText: 'Chọn',
      errorFormatText: 'Định dạng ngày không hợp lệ',
      errorInvalidText: 'Ngày không hợp lệ',
      fieldLabelText: 'Chọn ngày',
      fieldHintText: 'Tháng/Ngày/Năm',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.red, // Màu chủ đạo của lịch
            hintColor: Colors.red, // Màu nút chọn
            colorScheme: ColorScheme.light(primary: Colors.red),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _startDate1) {
      setState(() {
        _startDate1 = picked;
      });
    }
    // Hiển thị thứ và tháng bằng tiếng Việt
    print(DateFormat.yMMMMEEEEd('vi').format(picked!));
  }

  Future<void> _selectStartDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate2 ?? _startDate1 ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale('vi', ''), // Tiếng Việt,
      // Thay đổi các lời nhắc sang tiếng Việt
      helpText: 'Chọn ngày',
      cancelText: 'Hủy',
      confirmText: 'Chọn',
      errorFormatText: 'Định dạng ngày không hợp lệ',
      errorInvalidText: 'Ngày không hợp lệ',
      fieldLabelText: 'Chọn ngày',
      fieldHintText: 'Tháng/Ngày/Năm',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.red, // Màu chủ đạo của lịch
            hintColor: Colors.red, // Màu nút chọn
            colorScheme: ColorScheme.light(primary: Colors.red),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _startDate2) {
      if (_startDate1 == null || picked.isAfter(_startDate1!)) {
        setState(() {
          _startDate2 = picked;
        });
      } else {
        // Xử lý trường hợp ngày kết thúc được chọn sớm hơn ngày bắt đầu
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Lỗi'),
              content:
                  const Text('Ngày kết thúc không thể trước ngày bắt đầu.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Đóng'),
                ),
              ],
            );
          },
        );
      }
    }
    // Hiển thị thứ và tháng bằng tiếng Việt
    print(DateFormat.yMMMMEEEEd('vi').format(picked!));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          'Theo dõi hải trình',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.height * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'lib/assets/images/bg.png',
                        width: screenSize.height * 0.04,
                        height: screenSize.height * 0.035,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenSize.height * 0.02,
                  ),
                  Column(
                    children: [
                      Text(
                        "Số hiệu tàu",
                        style: TextStyle(fontSize: screenSize.width * 0.045),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * 0.03),
                        child: CustomDropdown(
                          items: listBoats.isNotEmpty ? listBoats : [],
                          selectedValue: listBoats.isNotEmpty
                              ? listBoats.firstWhere(
                                  (boat) =>
                                      boat.soHieuTau == selectedBoatSoHieuTau,
                                  orElse: () => Boat(
                                      soHieuTau: 'soHieuTau',
                                      thuyenTruong: 'thuyenTruong',
                                      loaiThietBi: 'loaiThietBi',
                                      tenThietBi: 'tenThietBi',
                                      imo: 'imo',
                                      soKepChi: 'soKepChi',
                                      ngayNiemPhong: 'ngayNiemPhong',
                                      ngayDangKi: 'ngayDangKi',
                                      ngayHetHanDangKy: 'ngayHetHanDangKy'))
                              : Boat(
                                  soHieuTau: 'soHieuTau',
                                  thuyenTruong: 'thuyenTruong',
                                  loaiThietBi: 'loaiThietBi',
                                  tenThietBi: 'tenThietBi',
                                  imo: 'imo',
                                  soKepChi: 'soKepChi',
                                  ngayNiemPhong: 'ngayNiemPhong',
                                  ngayDangKi: 'ngayDangKi',
                                  ngayHetHanDangKy: 'ngayHetHanDangKy'),
                          onChanged: (Boat value) {
                            setState(() {
                              selectedBoatSoHieuTau = value.soHieuTau;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    height: MediaQuery.of(context).size.width / 4,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'lib/assets/images/location.png',
                              width: screenSize.width * 0.05,
                              height: screenSize.width * 0.055,
                              color: Colors.green,
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Text(
                                "Ngày bắt đầu",
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.045),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: _startDate1 == null
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: screenSize.width * 0.02),
                                        child: Text(
                                          'Chọn ngày',
                                          style: TextStyle(
                                              fontSize: screenSize.width * 0.03,
                                              color: Colors.black),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: screenSize.width * 0.03),
                                        child: Text(
                                          '${_startDate1!.day}/${_startDate1!.month}/${_startDate1!.year} ',
                                          style: TextStyle(
                                              fontSize:
                                                  screenSize.width * 0.03),
                                        ),
                                      ),
                              ),
                              TextButton(
                                onPressed: () => _selectStartDate1(context),
                                child: Icon(Icons.arrow_drop_down,
                                    size: screenSize.width * 0.08,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      height: MediaQuery.of(context).size.width / 4,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'lib/assets/images/location.png',
                                width: screenSize.width * 0.05,
                                height: screenSize.width * 0.055,
                                color: Colors.red,
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Text(
                                  "Ngày kết thúc",
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.045),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: _startDate2 == null
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: screenSize.height * 0.01),
                                          child: Text(
                                            'Chọn ngày',
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.width * 0.03,
                                                color: Colors.black),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              left: screenSize.width * 0.03),
                                          child: Text(
                                            '${_startDate2!.day}/${_startDate2!.month}/${_startDate2!.year} ',
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.width * 0.03),
                                          ),
                                        ),
                                ),
                                TextButton(
                                  onPressed: () => _selectStartDate2(context),
                                  child: Icon(Icons.arrow_drop_down,
                                      size: screenSize.width * 0.08,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    onTap: () {
                      // Kiểm tra xem cả ngày bắt đầu và ngày kết thúc đã được chọn hay chưa
                      if (_startDate1 != null && _startDate2 != null) {
                        _onSearchButtonPressed(); // Khi nhấn nút "Tìm kiếm", hiển thị lịch sử tàu
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Thông tin tìm kiếm'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      'Ngày bắt đầu: ${_startDate1!.day}/${_startDate1!.month}/${_startDate1!.year}'),
                                  Text(
                                      'Ngày kết thúc: ${_startDate2!.day}/${_startDate2!.month}/${_startDate2!.year}'),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Đóng'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Lỗi'),
                              content: const Text(
                                  'Vui lòng chọn cả ngày bắt đầu và ngày kết thúc.'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Đóng'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    color: Colors.red,
                    text: "Tìm kiếm",
                    width: screenSize.width * 0.26,
                    height: screenSize.height * 0.045,
                    textStyle: TextStyle(
                        fontSize: screenSize.width * 0.042,
                        color: Colors.white),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                height: 625,
                child: Stack(
                  children: [
                    if (!showShipHistory) PolylineMap(),
                    // Hiển thị PolylineMap nếu showShipHistory là false
                    Visibility(
                      visible: showShipHistory,
                      child: ShipHistoryWidget(
                        selectedBoat: selectedSoHieuTau,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm xử lý sự kiện khi nhấn nút "Tìm kiếm"
  void _onSearchButtonPressed() {
    setState(() {
      selectedSoHieuTau = selectedBoatSoHieuTau; // Cập nhật tàu được chọn
      if (_startDate1 != null && _startDate2 != null) {
        // Kiểm tra nếu ngày bắt đầu là ngày 23/11/2023 và ngày kết thúc là 13/1/2024
        if (_startDate1!.isAtSameMomentAs(DateTime(2023, 11, 29)) &&
            _startDate2!.isAtSameMomentAs(DateTime(2024, 1, 13))) {
          // Hiển thị lịch sử tàu
          showShipHistory = true;
          // Thực hiện các thao tác cần thiết khi tìm thấy dữ liệu lịch sử tàu
        } else {
          // Hiển thị thông báo hoặc xử lý tùy ý khi không tìm thấy dữ liệu lịch sử tàu
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Thông báo'),
                content: const Text(
                    'Không tìm thấy dữ liệu lịch sử tàu cho thời gian đã chọn.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Đóng'),
                  ),
                ],
              );
            },
          );
        }
      }
    });
  }
}
