import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;
  final List<String> items;
  final String hintLabel;
  final bool? enabled;
  const CustomDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    required this.hintLabel,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      barrierDismissible: false,

      onChanged: enabled == true ? onChanged : null,

      items: items
          .map((val) => DropdownMenuItem(value: val, child: Text(val)))
          .toList(),
      hint: Text(hintLabel),
      value: value,
    );
  }
}
