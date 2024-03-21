import 'package:flutter/material.dart';

import '../models/boatModel.dart';

class CustomDropdown extends StatelessWidget {
  final List<Boat> items;
  final Boat selectedValue;
  final ValueChanged<Boat>? onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.selectedValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Boat>(
      value: selectedValue,
      onChanged: onChanged != null ? (Boat? value) => onChanged!(value!) : null,
      items: items.map((Boat boat) {
        return DropdownMenuItem<Boat>(
          value: boat,
          child: Text(boat.soHieuTau), // Display soHieuTau property
        );
      }).toList(),
      menuMaxHeight: 250,
    );
  }
}
