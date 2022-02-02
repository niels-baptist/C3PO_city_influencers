import 'package:flutter/material.dart';

typedef MyCallback = void Function(String gender);

class GenderDropdownButton extends StatelessWidget {
  final String labelText;
  final String? selectedGender;
  final List<String> genders;
  final MyCallback onGenderSelected;

  const GenderDropdownButton({
    Key? key,
    required this.labelText,
    required this.selectedGender,
    required this.genders,
    required this.onGenderSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(labelText, style: const TextStyle(color: Colors.black)),
      ),
      isExpanded: true,
      items: genders.map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      value: selectedGender,
      onChanged: (value) {
        onGenderSelected(value!);
      },
    );
  }
}
