import 'package:dry_living_mock_wall_unit/wall_unit/app_state_extention.dart';
import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../display_enum.dart';
import '../../label_value_widget.dart';

class WallUnitEditMenu extends StatelessWidget {
  final AppState appState;
  final VoidCallback onBack;
  final ValueChanged<DisplayEnum> onFieldSelected;
  final SizedBox spaceBox;

  const WallUnitEditMenu({
    super.key,
    required this.appState,
    required this.onBack,
    required this.onFieldSelected,
    required this.spaceBox,
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
            'Adjust settings below',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          spaceBox,
          Expanded(
            child: ListView(
              children: DisplayEnum.values
                  .where((f) => f != DisplayEnum.home && f != DisplayEnum.editMenu)
                  .map((field) {
                final label = _labelForField(field);
                final value = _valueForField(field, appState) ?? '';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: LabelValueWidget(
                    label: label,
                    value: value,
                    onTap: () => onFieldSelected(field),
                  ),
                );
              }).toList(),
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

  String _labelForField(DisplayEnum field) {
    switch (field) {
      case DisplayEnum.mode:
        return 'Mode';
      case DisplayEnum.fanSpeed:
        return 'Fan Speed';
      case DisplayEnum.externalVent:
        return 'External Vent';
      case DisplayEnum.targetHumidity:
        return 'Target Humidity';
      case DisplayEnum.home:
      case DisplayEnum.editMenu:
      case DisplayEnum.infoMenu:
      case DisplayEnum.version:
        return '';
    }
  }

  String? _valueForField(DisplayEnum field, AppState appState) {
    switch (field) {
      case DisplayEnum.mode:
        return appState.mode.displayName;
      case DisplayEnum.fanSpeed:
        return appState.fanSpeed.displayName;
      case DisplayEnum.externalVent:
        return appState.externalVent.displayName;
      case DisplayEnum.targetHumidity:
        return '${appState.targetHumidity}%';
      case DisplayEnum.home:
      case DisplayEnum.editMenu:
      case DisplayEnum.infoMenu:
      case DisplayEnum.version:
        return null;
    }
  }
}
