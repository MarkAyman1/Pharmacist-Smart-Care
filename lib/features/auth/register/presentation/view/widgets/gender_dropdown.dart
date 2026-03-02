import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const GenderDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((g) => DropdownMenuItem(
                value: g,
                child: Text(g),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.male),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
      ),
      validator: (v) => v == null ? "Required" : null,
    );
  }
}