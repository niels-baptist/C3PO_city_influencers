import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:flutter/material.dart';


typedef MyCallback = void Function(Domain selectedDomain);

class DomainDropdownButton extends StatelessWidget {
  final String labelText;
  final Domain? selectedDomain;
  final List<Domain> domains;
  final MyCallback onDomainSelected;

  const DomainDropdownButton(
      {Key? key,
      required this.labelText,
      required this.selectedDomain,
      required this.domains,
      required this.onDomainSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Domain>(
      hint: Align(
        child: Text(
            labelText,
        ),
      ),
      isExpanded: true,
      items: domains.map((Domain domain) {
        return DropdownMenuItem<Domain>(
          value: domain,
          child: Text(domain.name),
        );
      }).toList(),
      value: selectedDomain,
      onChanged: (value) {
        onDomainSelected(value!);
      },
    );
  }
}