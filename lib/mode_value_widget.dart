import 'package:flutter/material.dart';

class ModeValueWidget extends StatelessWidget {
  const ModeValueWidget({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}