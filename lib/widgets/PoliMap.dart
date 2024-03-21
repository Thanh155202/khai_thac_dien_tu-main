import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
class ShipLocation {
  final String shipCode;
  final String captain;
  final Location location; // Thêm thông tin vị trí
  final String time;

  ShipLocation({
    required this.shipCode,
    required this.captain,
    required this.location,
    required this.time,
  });
}

class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});
}

class PolylineMap extends StatefulWidget {
  @override
  _PolylineMapState createState() => _PolylineMapState();
}

class _PolylineMapState extends State<PolylineMap> {
  late GoogleMapController mapController;
  List<LatLng> polylineCoordinates = [];
  List<ShipLocation> shipLocations = [];
  @override
  void initState() {
    super.initState();
    fetchShipLocations();
  }
  Future<void> fetchShipLocations() async {
    final response = await http.get(Uri.parse('https://nhatkydientu.vn/mobile-api/realtime-location/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> shipList = data['ship_list'];
      setState(() {
        shipLocations = shipList
            .map((shipData) => ShipLocation(
          shipCode: shipData['so_hieu_tau'],
          captain: shipData['thuyen_truong'],
          location: Location(
            latitude: shipData['location']['lat'],
            longitude: shipData['location']['lng'],
          ),
          time: shipData['time'],
        ))
            .toList();
      });
    } else {
      throw Exception('Failed to load ship locations');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _createMarkers(),
        polylines: _createPolylines(),
        initialCameraPosition: CameraPosition(
          target: LatLng(14.0583, 108.2772),
          zoom: 7.0,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      // polylineCoordinates.add(LatLng(21.532618, 108.056009));
      // polylineCoordinates.add(LatLng(20.4017, 108.3792));
      // polylineCoordinates.add(LatLng(19.9583, 107.93));
      // polylineCoordinates.add(LatLng(19.6583, 107.5283));
      // polylineCoordinates.add(LatLng(19.4233, 107.35));
      // polylineCoordinates.add(LatLng(19.4233, 107.2117));
      // polylineCoordinates.add(LatLng(19.2683, 107.19));
      // polylineCoordinates.add(LatLng(19.215, 107.16));
      // polylineCoordinates.add(LatLng(18.715, 107.16));
      // polylineCoordinates.add(LatLng(18.23, 107.5667));
      // polylineCoordinates.add(LatLng(18.1183, 107.6267));
      // polylineCoordinates.add(LatLng(18.07, 107.6517));
      // polylineCoordinates.add(LatLng(17.7833, 107.9667));
      // polylineCoordinates.add(LatLng(17.3317, 108.5572));
      // polylineCoordinates.add(LatLng(16.7817, 109.4958));
      // polylineCoordinates.add(LatLng(16.4481, 110.9795));
      // polylineCoordinates.add(LatLng(17.4598, 111.2896));
      // polylineCoordinates.add(LatLng(17.5515, 111.3583));
      // polylineCoordinates.add(LatLng(17.6065, 111.4434));
      // polylineCoordinates.add(LatLng(17.6274, 111.5286));
      // polylineCoordinates.add(LatLng(17.6274, 111.6192));
      // polylineCoordinates.add(LatLng(17.5515, 112.1438));
      // polylineCoordinates.add(LatLng(17.5017, 112.4322));
      // polylineCoordinates.add(LatLng(17.3524, 112.7453));
      // polylineCoordinates.add(LatLng(17.2212, 112.9486));
      // polylineCoordinates.add(LatLng(17.1517, 112.9843));
      // polylineCoordinates.add(LatLng(17.0822, 112.9815));
      // polylineCoordinates.add(LatLng(17.4329, 113.5533));
      // polylineCoordinates.add(LatLng(18.5129, 114.6131));
      // polylineCoordinates.add(LatLng(18.9288, 116.1876));
      // polylineCoordinates.add(LatLng(19.743, 117.6259));
      // polylineCoordinates.add(LatLng(18.6421, 117.4442));
      // polylineCoordinates.add(LatLng(17.8225, 116.99));
      // polylineCoordinates.add(LatLng(16.2592, 116.5207));
      // polylineCoordinates.add(LatLng(13.8618, 116.8083));
      // polylineCoordinates.add(LatLng(13.8471, 116.8235));
      // polylineCoordinates.add(LatLng(12.6799, 116.4964));
      // polylineCoordinates.add(LatLng(11.93, 115.7554));
      // polylineCoordinates.add(LatLng(12.1166, 116.7854));
      // polylineCoordinates.add(LatLng(11.118, 117.8153));
      // polylineCoordinates.add(LatLng(10.3488, 117.9698));
      // polylineCoordinates.add(LatLng(9, 115.9814));
      // polylineCoordinates.add(LatLng(7.66, 115.7554));
      // polylineCoordinates.add(LatLng(6.74, 113.6954));
      // polylineCoordinates.add(LatLng(7.6634, 112.5625));
      // polylineCoordinates.add(LatLng(6.262, 111.0175));
      // polylineCoordinates.add(LatLng(6.8375, 109.2869));
      // polylineCoordinates.add(LatLng(6.35, 106.6605));
      // polylineCoordinates.add(LatLng(6.25, 106.3169));
      // polylineCoordinates.add(LatLng(6.25, 106.2));
      // polylineCoordinates.add(LatLng(6.0967, 105.82));
      // polylineCoordinates.add(LatLng(7.05, 103.8667));
      // polylineCoordinates.add(LatLng(7.3052, 103.5953));
      // polylineCoordinates.add(LatLng(7.5667, 103.3167));
      // polylineCoordinates.add(LatLng(7.7, 102.9667));
      // polylineCoordinates.add(LatLng(7.7122, 102.9512));
      // polylineCoordinates.add(LatLng(7.8167, 103.0417));
      // polylineCoordinates.add(LatLng(8.7819, 102.2032));
      // polylineCoordinates.add(LatLng(9.5834, 103.1711));
      // polylineCoordinates.add(LatLng(9.9167, 102.8917));
      // polylineCoordinates.add(LatLng(9.9033, 102.92));
      // polylineCoordinates.add(LatLng(9.9083, 102.95));
      // polylineCoordinates.add(LatLng(10.4017, 103.8));
      // polylineCoordinates.add(LatLng(10.4267, 103.82));
      // polylineCoordinates.add(LatLng(10.5, 103.79));
      // polylineCoordinates.add(LatLng(10.54, 103.8033));
      polylineCoordinates.add(LatLng(10.54, 103.8033));
      polylineCoordinates.add(LatLng(10.5, 103.79));
      polylineCoordinates.add(LatLng(10.4267, 103.82));
      polylineCoordinates.add(LatLng(10.4017, 103.8));
      polylineCoordinates.add(LatLng(9.9083, 102.95));
      polylineCoordinates.add(LatLng(9.9033, 102.92));
      polylineCoordinates.add(LatLng(9.9167, 102.8917));
      polylineCoordinates.add(LatLng(9.5834, 103.1711));
      polylineCoordinates.add(LatLng(8.7817, 102.2017));
      polylineCoordinates.add(LatLng(7.8167, 103.0417));
      polylineCoordinates.add(LatLng(7.3667, 103.7083));
      polylineCoordinates.add(LatLng(7.3333, 103.65));
      polylineCoordinates.add(LatLng(7.3052, 103.5952));
      polylineCoordinates.add(LatLng(7.05, 103.8667));
      polylineCoordinates.add(LatLng(6.0967, 105.82));
      polylineCoordinates.add(LatLng(6.25, 106.2));
      polylineCoordinates.add(LatLng(6.25, 106.3167));
      polylineCoordinates.add(LatLng(6.35, 106.6617));
      polylineCoordinates.add(LatLng(6.8367, 109.2867));
      polylineCoordinates.add(LatLng(6.415, 109.5683));
      polylineCoordinates.add(LatLng(5.8527, 109.8414));
      polylineCoordinates.add(LatLng(6.2499, 111.0243));
      polylineCoordinates.add(LatLng(7.6619, 112.562));
      polylineCoordinates.add(LatLng(6.7392, 113.6883));
      polylineCoordinates.add(LatLng(7.6619, 115.7617));
      polylineCoordinates.add(LatLng(9.0214, 116));
      polylineCoordinates.add(LatLng(10.345, 117.9783));
      polylineCoordinates.add(LatLng(11.1183, 117.8283));
      polylineCoordinates.add(LatLng(12.1233, 116.8217));
      polylineCoordinates.add(LatLng(11.9267, 115.7667));
      polylineCoordinates.add(LatLng(12.6682, 116.496));
      polylineCoordinates.add(LatLng(13.8471, 116.8235));
      polylineCoordinates.add(LatLng(13.8618, 116.8083));
      polylineCoordinates.add(LatLng(16.2592, 116.5207));
      polylineCoordinates.add(LatLng(17.8225, 116.99));
      polylineCoordinates.add(LatLng(18.6421, 117.4442));
      polylineCoordinates.add(LatLng(19.743, 117.6259));
      polylineCoordinates.add(LatLng(18.9288, 116.1876));
      polylineCoordinates.add(LatLng(18.5129, 114.6131));
      polylineCoordinates.add(LatLng(17.4329, 113.5533));
      polylineCoordinates.add(LatLng(17.0822, 112.9815));
      polylineCoordinates.add(LatLng(17.1517, 112.9843));
      polylineCoordinates.add(LatLng(17.2212, 112.9486));
      polylineCoordinates.add(LatLng(17.3524, 112.7453));
      polylineCoordinates.add(LatLng(17.5017, 112.4322));
      polylineCoordinates.add(LatLng(17.5515, 112.1438));
      polylineCoordinates.add(LatLng(17.6274, 111.6192));
      polylineCoordinates.add(LatLng(17.6274, 111.5286));
      polylineCoordinates.add(LatLng(17.6065, 111.4434));
      polylineCoordinates.add(LatLng(17.5515, 111.3583));
      polylineCoordinates.add(LatLng(17.4598, 111.2896));
      polylineCoordinates.add(LatLng(16.4726, 111.0939));
      polylineCoordinates.add(LatLng(16.4481, 110.9795));
      polylineCoordinates.add(LatLng(16.7817, 109.4958));
      polylineCoordinates.add(LatLng(17.3317, 108.5572));
      polylineCoordinates.add(LatLng(17.7833, 107.9667));
      polylineCoordinates.add(LatLng(18.07, 107.6517));
      polylineCoordinates.add(LatLng(18.1183, 107.6267));
      polylineCoordinates.add(LatLng(18.23, 107.5667));
      polylineCoordinates.add(LatLng(18.715, 107.16));
      polylineCoordinates.add(LatLng(19.215, 107.16));
      polylineCoordinates.add(LatLng(19.2683, 107.19));
      polylineCoordinates.add(LatLng(19.4233, 107.2117));
      polylineCoordinates.add(LatLng(19.4233, 107.35));
      polylineCoordinates.add(LatLng(19.6583, 107.5283));
      polylineCoordinates.add(LatLng(19.9583, 107.93));
      polylineCoordinates.add(LatLng(20.4017, 108.3792));
      polylineCoordinates.add(LatLng(21.21, 108.2083));
      polylineCoordinates.add(LatLng(21.275, 108.135));
      polylineCoordinates.add(LatLng(21.4517, 108.095));
      polylineCoordinates.add(LatLng(21.4567, 108.0933));
      polylineCoordinates.add(LatLng(21.4583, 108.095));
      polylineCoordinates.add(LatLng(21.46, 108.0967));
      polylineCoordinates.add(LatLng(21.4633, 108.0983));
      polylineCoordinates.add(LatLng(21.4667, 108.1));
      polylineCoordinates.add(LatLng(21.47, 108.1));

    });
  }
  Set<Polyline> _createPolylines() {
    Set<Polyline> polylines = Set<Polyline>();
    if (polylineCoordinates.isNotEmpty) {
      Polyline polyline = Polyline(
        polylineId: PolylineId("poly"),
        color: Colors.blue,
        points: polylineCoordinates,
        width: 1,
      );
      polylines.add(polyline);
    }
    return polylines;
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = Set<Marker>();
    for (ShipLocation shipLocation in shipLocations) {
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), // Adjust the size as needed
        'lib/assets/images/bg13.png',
      ).then((bitmapDescriptor) {
        markers.add(
          Marker(
            markerId: MarkerId(shipLocation.shipCode),
            icon: bitmapDescriptor,
            position: LatLng(shipLocation.location.latitude, shipLocation.location.longitude),
            onTap: () => _onMarkerTapped(
              shipLocation.shipCode,
              shipLocation.captain,
              shipLocation.location,
              shipLocation.time,
            ),
          ),
        );


      });
    }
    return markers;
  }

  void _onMarkerTapped(String nameship, String namethuyen, Location location, String updateTime) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông tin thuyền"),
          content: Container(
            height: 200,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Chi tiết')),
                DataColumn(label: Text('Thông tin')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Tên thuyền')),
                  DataCell(Text(nameship)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Thuyền trưởng')),
                  DataCell(Text(namethuyen)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Vị trí')),
                  DataCell(Text('${location.latitude}, ${location.longitude}')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Thời gian cập nhật')),
                  DataCell(Text(updateTime)),
                ]),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); //
                },
                child: Text("Đóng"),
              ),
            ),
          ],
        );
      },
    );
  }
}
