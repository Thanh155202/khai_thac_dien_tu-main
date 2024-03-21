import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:originproject/widgets/screenshipHistory.dart';

class ShipHistory {
  final String message;
  final int status;
  final Map<String, ShipData> log;

  const ShipHistory({
    required this.message,
    required this.status,
    required this.log,
    required List positions,
  });

  factory ShipHistory.fromJson(Map<String, dynamic> json) {
    Map<String, ShipData> logData = {};
    json['log'].forEach((key, value) {
      logData[key] = ShipData.fromJson(value);
    });
    return ShipHistory(
      message: json['message'],
      status: json['status'],
      log: logData,
      positions: [],
    );
  }
}

class ShipData {
  final ShipGeneralInfo generalInfo;
  final List<JournalEntry> journal;

  const ShipData({
    required this.generalInfo,
    required this.journal,
  });

  factory ShipData.fromJson(Map<String, dynamic> json) {
    List<JournalEntry> journalEntries = [];
    json['journal'].forEach((entry) {
      journalEntries.add(JournalEntry.fromJson(entry));
    });
    return ShipData(
      generalInfo: ShipGeneralInfo.fromJson(json['thong_tin_chung']),
      journal: journalEntries,
    );
  }
}

class ShipGeneralInfo {
  final String shipCode;
  final String captain;
  final String owner;
  final String deviceType;
  final String deviceName;
  final String IMO;
  final String registrationDate;
  final String expirationDate;
  final String certificateNumber;
  final String sealDate;

  const ShipGeneralInfo({
    required this.shipCode,
    required this.captain,
    required this.owner,
    required this.deviceType,
    required this.deviceName,
    required this.IMO,
    required this.registrationDate,
    required this.expirationDate,
    required this.certificateNumber,
    required this.sealDate,
  });

  factory ShipGeneralInfo.fromJson(Map<String, dynamic> json) {
    return ShipGeneralInfo(
      shipCode: json['so_hieu_tau'],
      captain: json['thuyen_truong'],
      owner: json['chu_tau'],
      deviceType: json['loai_thiet_bi'],
      deviceName: json['ten_thiet_bi'],
      IMO: json['IMO'],
      registrationDate: json['ngay_dang_ky'],
      expirationDate: json['ngay_het_han_dang_ky'],
      certificateNumber: json['so_kep_chi'],
      sealDate: json['ngay_niem_phong'],
    );
  }
}

class JournalEntry {
  final double latitude;
  final double longitude;
  final String date;

  const JournalEntry({
    required this.latitude,
    required this.longitude,
    required this.date,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      latitude: json['lat'],
      longitude: json['lng'],
      date: json['date'],
    );
  }
}

class ShipHistoryWidget extends StatefulWidget {
  final String selectedBoat; // Thêm trường này để nhận dữ liệu tàu được chọn

  const ShipHistoryWidget({Key? key, required this.selectedBoat})
      : super(key: key);

  @override
  _ShipHistoryWidgetState createState() => _ShipHistoryWidgetState();
}

class _ShipHistoryWidgetState extends State<ShipHistoryWidget> {
  ShipHistory? shipHistory;
  List<LatLng> coordinates = [];
  ShipData? selectedShipData;

  @override
  void initState() {
    super.initState();
    fetchShipHistory();
  }

  Future<void> fetchShipHistory() async {
    // Lấy lịch sử tàu từ API
    final response = await http.get(
        Uri.parse('https://nhatkydientu.vn/mobile-api/ship-location-logs/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        shipHistory = ShipHistory.fromJson(data);
      });
    } else {
      throw Exception('Failed to load ship history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử tàu'),
        automaticallyImplyLeading: false, // Xóa icon back
      ),
      body: shipHistory == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: shipHistory!.log.length,
              itemBuilder: (context, index) {
                String key = shipHistory!.log.keys.elementAt(index);
                ShipData shipData = shipHistory!.log[key]!;
                // Chỉ hiển thị thông tin của tàu được chọn
                if (shipData.generalInfo.shipCode == widget.selectedBoat) {
                  return ListTile(
                    title: Text(shipData.generalInfo.shipCode),
                    subtitle: Text(shipData.generalInfo.captain),
                    onTap: () {
                      // Chọn tàu và hiển thị thông tin
                      _showShipDetailsscreen(shipData);
                      _printCoordinates(shipData);
                    },
                  );
                } else {
                  return const SizedBox.shrink(); // Ẩn các tàu không được chọn
                }
              },
            ),
    );
  }

  void _printCoordinates(ShipData shipData) {
    print('Coordinates for ${shipData.generalInfo.shipCode}:');
    for (var entry in shipData.journal) {
      print('${entry.latitude}, ${entry.longitude}');
    }
  }

  Future<void> _showShipDetailsscreen(ShipData shipData) async {
    selectedShipData = shipData;
    coordinates.clear(); // Xóa tọa độ trước đó
    List<LatLng> shipCoordinates = [];
    for (var entry in shipData.journal) {
      shipCoordinates.add(LatLng(entry.latitude, entry.longitude));
    }


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShipDetailsWidget(
          shipData: shipData,
          coordinates: coordinates,
          markers: _createMarkers(coordinates),
          polylines: _createPolylines(coordinates),
        ),
      ),
    );
  }
}

Set<Marker> _createMarkers(List<LatLng> coordinates) {
  return coordinates.map((coordinate) {
    return Marker(
      markerId: MarkerId(coordinate.toString()),
      position: coordinate,
    );
  }).toSet();
}

// Hàm tạo đường nối giữa các điểm trong journal
Set<Polyline> _createPolylines(List<LatLng> coordinates) {
  if (coordinates.length < 4) {
    return {};
  }
// Chỉ sử dụng 2 điểm đầu tiên trong danh sách tọa độ
  List<LatLng> polylineCoordinates = coordinates.sublist(0, 3);

  return {
    Polyline(
      polylineId: const PolylineId('route'),
      points: polylineCoordinates,
      color: Colors.blue,
      width: 4,
    ),
  };
}
