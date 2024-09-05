import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final Function(String) onChanged; // A callback for when the value changes

  const CustomSearchField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
