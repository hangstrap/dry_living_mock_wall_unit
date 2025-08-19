import 'package:dry_living_mock_wall_unit/wall_unit/app_state_extention.dart';
import 'package:flutter/material.dart';
import '../app_state.dart';
import 'editing_field_enum.dart';
import '../label_value_widget.dart';

class WallUnitSettingsMenu extends StatelessWidget {
  final AppState appState;
  final VoidCallback onBack;
  final ValueChanged<EditingField> onFieldSelected;
  final SizedBox spaceBox;

  const WallUnitSettingsMenu({
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
              children: EditingField.values
                  .where((f) => f != EditingField.home && f != EditingField.editMenu)
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

  String _labelForField(EditingField field) {
    switch (field) {
      case EditingField.mode:
        return 'Mode';
      case EditingField.fanSpeed:
        return 'Fan Speed';
      case EditingField.externalVent:
        return 'External Vent';
      case EditingField.targetHumidity:
        return 'Target Humidity';
      case EditingField.home:
      case EditingField.editMenu:
        return '';
    }
  }

  String? _valueForField(EditingField field, AppState appState) {
    switch (field) {
      case EditingField.mode:
        return appState.mode.displayName;
      case EditingField.fanSpeed:
        return appState.fanSpeed.displayName;
      case EditingField.externalVent:
        return appState.externalVent.displayName;
      case EditingField.targetHumidity:
        return '${appState.targetHumidity}%';
      case EditingField.home:
      case EditingField.editMenu:
        return null;
    }
  }
}
