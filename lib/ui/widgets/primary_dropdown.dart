import 'package:flutter/material.dart';

class PrimaryDropdown extends StatelessWidget {
  const PrimaryDropdown(
      {super.key,
      required this.value,
      required this.inputList,
      required this.onChanged});

  final String value;
  final List<String> inputList;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(9)),
      height: 28,
      child: DropdownButton(
        borderRadius: BorderRadius.circular(4),
        value: value,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: false,
        items: inputList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: const TextStyle(
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
