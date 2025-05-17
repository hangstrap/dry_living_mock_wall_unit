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
      child: Row(
        children: [
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: Text(label)),
          ),
          SizedBox(width: 20), // optional spacing
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                captalise(value),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String captalise(String str) {
    return str[0].toUpperCase() + str.substring(1);
  }
}
