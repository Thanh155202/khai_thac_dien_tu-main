import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Ship {
  final String shipCode;
  final List<Voyage> voyages;

  Ship({required this.shipCode, required this.voyages});
}

class Voyage {
  final int voyageNumber;
  final List<FishBatch> fishBatches;

  Voyage({required this.voyageNumber, required this.fishBatches});
}

class FishBatch {
  final int batchNumber;
  final List<FishData> fishDataList;

  FishBatch({required this.batchNumber, required this.fishDataList});
}

class FishData {
  final String fishType;
  final int weight;

  FishData({required this.fishType, required this.weight});
}

class NhatKi extends StatefulWidget {
  @override
  _NhatKiState createState() => _NhatKiState();
}

class _NhatKiState extends State<NhatKi> {
  late Future<List<Ship>> ships;
  Ship? selectedShip;
  Voyage? selectedVoyage;
  bool showImage = true; // Initial state is to show the image

  @override
  void initState() {
    super.initState();
    ships = fetchShips();
  }

  Future<List<Ship>> fetchShips() async {
    final response = await http.get(Uri.parse('https://nhatkydientu.vn/mobile-api/mining-log/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      List<Ship> shipList = [];
      for (var shipData in jsonData) {
        List<Voyage> voyageList = [];
        for (var voyageData in shipData['danh_sach_chuyen_bien']) {
          List<FishBatch> fishBatchList = [];
          for (var fishBatchData in voyageData['danh_sach_me_ca']) {
            List<FishData> fishDataList = [];
            for (var fishData in fishBatchData['du_lieu_me_ca']) {
              FishData fish = FishData(
                fishType: fishData['ten_loai_ca'],
                weight: fishData['khoi_luong'],
              );
              fishDataList.add(fish);
            }
            FishBatch fishBatch = FishBatch(
              batchNumber: fishBatchData['me_ca'],
              fishDataList: fishDataList,
            );
            fishBatchList.add(fishBatch);
          }
          Voyage voyage = Voyage(
            voyageNumber: voyageData['chuyen_bien_so'],
            fishBatches: fishBatchList,
          );
          voyageList.add(voyage);
        }
        Ship ship = Ship(
          shipCode: shipData['so_hieu_tau'],
          voyages: voyageList,
        );
        shipList.add(ship);
      }
      return shipList;
    } else {
      throw Exception('Failed to load ships');
    }
  }

  DataTable buildFishDataTable(FishBatch fishBatch) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Loại cá')),
        DataColumn(label: Text('Khối lượng (kg)')),
      ],
      rows: fishBatch.fishDataList
          .map((fishData) => DataRow(
        cells: [
          DataCell(Text(fishData.fishType, style: TextStyle(fontSize: 17),)),
          DataCell(Text(fishData.weight.toString(),style: TextStyle(fontSize: 17))),
        ],
      ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(
            'Nhật ký khai thác',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: FutureBuilder<List<Ship>>(
              future: ships,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButton<Ship>(
                                  items: snapshot.data!
                                      .map((ship) => DropdownMenuItem<Ship>(
                                    value: ship,
                                    child: Text("Tàu: " + ship.shipCode, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                  ))
                                      .toList(),
                                  onChanged: (Ship? value) {
                                    setState(() {
                                      selectedShip = value;
                                      selectedVoyage = value?.voyages.first;
                                      showImage = false;; // Show the image when Ship is selected
                                    });
                                  },
                                  hint: Text('Chọn tàu'),
                                  value: selectedShip,
                                ),
                                SizedBox(height: 16),
                                DropdownButton<Voyage>(
                                  items: selectedShip?.voyages
                                      .map((voyage) => DropdownMenuItem<Voyage>(
                                    value: voyage,
                                    child: Text('Chuyến biển ${voyage.voyageNumber}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  ))
                                      .toList() ??
                                      [],
                                  onChanged: (Voyage? value) {
                                    setState(() {
                                      selectedVoyage = value;
                                      showImage = false; // Hide the image when Voyage is selected
                                    });
                                  },
                                  hint: Text('Chọn chuyến biển'),
                                  value: selectedVoyage,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 30,),
                        if (showImage) // Display image based on the showImage state
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0, right: 120, bottom: 250),
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.asset('lib/assets/images/search_info.png'),
                              ),
                          ),
                        if (selectedShip != null && selectedVoyage != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var fishBatch in selectedVoyage!.fishBatches)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Mẻ cá ${fishBatch.batchNumber}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 4),
                                    buildFishDataTable(fishBatch),
                                    SizedBox(height: 4),
                                  ],
                                ),
                            ],
                          ),
                        SizedBox(height: 16),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
