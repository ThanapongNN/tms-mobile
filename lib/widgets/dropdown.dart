import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

Widget dropdown({
  required List<String> items,
  void Function(String?)? onChanged,
  Color borderColor = Colors.grey,
  int? flex,
  String? selectedValue,
  String? hint,
}) {
  return Expanded(
    flex: flex ?? 1,
    child: DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(hint ?? '', style: const TextStyle(fontSize: 18)),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 18), overflow: TextOverflow.ellipsis),
                ))
            .toList(),
        value: selectedValue,
        onChanged: onChanged,
        isExpanded: true,
        itemHeight: 45,
        itemPadding: const EdgeInsets.symmetric(horizontal: 14),
        dropdownMaxHeight: 200,
        buttonPadding: const EdgeInsets.only(left: 10),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor),
        ),
      ),
    ),
  );
}
