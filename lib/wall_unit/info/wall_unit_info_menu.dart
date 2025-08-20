import 'package:flutter/material.dart';
import '../display_enum.dart';
import 'my_button.dart';

class WallUnitInfoMenu extends StatelessWidget {
  final VoidCallback onBack;
  final SizedBox spaceBox;
  final ValueChanged<DisplayEnum> onFieldSelected;

  const WallUnitInfoMenu({
    super.key,
    required this.onBack,
    required this.spaceBox,
    required this.onFieldSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 328,
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Device Info',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'FreeSans',
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          spaceBox,
          Expanded(
            child: ListView(
              children: [
                MyButton(
                  label: 'Version',
                  onPressed: () => onFieldSelected(DisplayEnum.version),
                ),
                MyButton(
                  label: 'Contact',
                  onPressed: () => onFieldSelected(DisplayEnum.contact),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack,
            ),
          ),
        ],
      ),
    );
  }
}
