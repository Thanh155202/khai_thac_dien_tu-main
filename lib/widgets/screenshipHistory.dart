import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:originproject/widgets/shipHistory.dart';

class ShipDetailsWidget extends StatefulWidget {
  final ShipData shipData;
  final List<LatLng> coordinates;
  final Set<Marker> markers;
  final Set<Polyline> polylines;

  const ShipDetailsWidget({
    Key? key,
    required this.shipData,
    required this.coordinates,
    required this.markers,
    required this.polylines,
  }) : super(key: key);

  @override
  _ShipDetailsWidgetState createState() => _ShipDetailsWidgetState();
}

class _ShipDetailsWidgetState extends State<ShipDetailsWidget> {
  late Set<Marker> markers; // Đặt late modifier cho biến markers
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    markers = _createMarkers(widget
        .coordinates); // Gọi hàm _createMarkers và lưu kết quả vào biến markers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          'Thông tin tàu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thông tin chung',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildInfoItem(
                  'Số hiệu tàu', widget.shipData.generalInfo.shipCode),
              _buildInfoItem(
                  'Thuyền trưởng', widget.shipData.generalInfo.captain),
              _buildInfoItem('Chủ tàu', widget.shipData.generalInfo.owner),
              _buildInfoItem(
                  'Loại thiết bị', widget.shipData.generalInfo.deviceType),
              _buildInfoItem(
                  'Tên thiết bị', widget.shipData.generalInfo.deviceName),
              _buildInfoItem('IMO', widget.shipData.generalInfo.IMO),
              _buildInfoItem(
                  'Ngày đăng ký', widget.shipData.generalInfo.registrationDate),
              _buildInfoItem('Ngày hết hạn đăng ký',
                  widget.shipData.generalInfo.expirationDate),
              _buildInfoItem(
                  'Số kép chì', widget.shipData.generalInfo.certificateNumber),
              _buildInfoItem(
                  'Ngày niêm phong', widget.shipData.generalInfo.sealDate),
              const SizedBox(height: 10),
              const Text(
                'Nhật ký',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10), // Thêm khoảng cách ở đây
              _buildJournalList(),
              const SizedBox(height: 10),
              SizedBox(
                height: 900,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: widget.coordinates.isNotEmpty
                        ? widget.coordinates.first
                        : const LatLng(12.0, 114.0),
                    zoom: 5,
                  ),
                  markers: markers,
                  polylines: _createPolylines(widget.coordinates),
                  onMapCreated: (controller) {
                    _mapController = controller;
                    // Thêm marker cho tọa độ cuối cùng khi bản đồ được tạo
                    _addEndMarker(widget.coordinates.last);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addEndMarker(LatLng position) async {
    // Tạo BitmapDescriptor từ hình ảnh tàu
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'lib/assets/images/fishing-boat-resize.png',
    );
    // Thêm marker vào danh sách markers
    setState(() {
      markers.add(
        Marker(
          markerId: const MarkerId('end'),
          position: position,
          icon: icon,
        ),
      );
    });
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJournalList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.shipData.journal.length,
      itemBuilder: (context, index) {
        final entry = widget.shipData.journal[index];
        widget.coordinates.add(LatLng(entry.latitude, entry.longitude));
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Text(
                '${entry.date}: ',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8), // Thêm khoảng cách ở đây
              Text(
                '${entry.latitude}, ${entry.longitude}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Set<Marker> _createMarkers(List<LatLng> coordinates) {
    Set<Marker> markers = {};
    for (var i = 0; i < coordinates.length; i++) {
      var markerId = MarkerId(i.toString());
      var marker = Marker(
        markerId: markerId,
        position: coordinates[i],
        // Đặt hình ảnh tượng trưng cho Marker
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      markers.add(marker);
    }
    return markers;
  }

  Set<Polyline> _createPolylines(List<LatLng> coordinates) {
    Set<Polyline> polylines = {};
    if (widget.coordinates.length >= 3) {
      // Lấy tọa độ của ba điểm đầu tiên
      List<LatLng> polylineCoordinates = [
        widget.coordinates[0],
        widget.coordinates[1],
        widget.coordinates[2],
      ];
      var polylineId = const PolylineId('polyline');
      var polyline = Polyline(
        polylineId: polylineId,
        color: Colors.blue,
        points: polylineCoordinates,
        width: 4,
      );
      polylines.add(polyline);
    }
    return polylines;
  }
}
