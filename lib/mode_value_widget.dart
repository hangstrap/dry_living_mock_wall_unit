import 'package:flutter/material.dart';
import 'roof_unit_state.dart';

class ModeValueWidget extends StatelessWidget {
  const ModeValueWidget({super.key, required this.mode, required this.onTap});

  final Mode mode;
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
                displayMode(mode),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String displayMode(Mode mode) {
    switch (mode) {
      case Mode.off:
        return 'Unit Off';
      case Mode.fanOnly:
        return 'Only Fan Only';
      case Mode.humidifier:
        return 'Dehumidifier Idle';
    }
  }
}

