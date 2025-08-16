import 'package:flutter/material.dart';

class LabelValueWidget extends StatelessWidget {
  const LabelValueWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: 
      Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text(label, style: TextStyle(fontSize: 14)),
    Text(_capitalize(value), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
  ],
)
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Text(
      //       label,
      //       style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      //     ),
      //     Text(
      //       _capitalize(value),
      //       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      //     ),
      //   ],
      // ),
    );
  }

  String _capitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }
}
