import 'package:flutter/material.dart';
import 'app_state.dart';

class ModeValueWidget extends StatelessWidget {
  const ModeValueWidget({super.key, required this.appState, required this.onTap});

  final AppState appState;
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
                appState.modalDisplay,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

