import 'package:flutter/material.dart';
import 'editing_field_enum.dart';

class WallUnitInfoMenu extends StatelessWidget {
  final VoidCallback onBack;
  final SizedBox spaceBox;
  final ValueChanged<EditingField> onFieldSelected;

  // You can add more info labels here as needed
  static const List<String> infoLabels = [
    'Version',
    'Contact',
    'Device ID',
    'Build Date',
  ];

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
      height: 328, // 360-32
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),  
      child: Column(
        children: [
          const Text(
            'Device Info',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          spaceBox,
          Expanded(
            child: ListView(
              children: [
                // "Version" as bold, clickable text
                GestureDetector(
                  onTap: () => onFieldSelected(EditingField.version),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Version',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // The rest are normal text
                ...infoLabels.skip(1).map((label) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        label,
                      ),
                    )),
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