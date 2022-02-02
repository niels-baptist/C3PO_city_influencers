import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:cityinfluencers_mobile/models/location.dart';
import 'package:flutter/material.dart';

typedef MyCallback = void Function(Location selectedLocation);

class LocationDropdownButton extends StatelessWidget {
  final String labelText;
  final Location? selectedLocation;
  final List<Location> locations;
  final MyCallback onLocationSelected;

  const LocationDropdownButton(
      {Key? key,
      required this.labelText,
      required this.selectedLocation,
      required this.locations,
      required this.onLocationSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Location>(
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          labelText,
        ),
      ),
      isExpanded: true,
      items: locations.map((Location location) {
        return DropdownMenuItem<Location>(
          value: location,
          child: Text(location.name),
        );
      }).toList(),
      value: selectedLocation,
      onChanged: (value) {
        onLocationSelected(value!);
      },
    );
  }
}
