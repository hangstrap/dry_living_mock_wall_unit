import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../app_state_extention.dart';
import 'base_field_edit_view.dart';
import 'enum_radio_selector.dart';

class FanSpeedEditView extends StatelessWidget {
  final AppState appState;
  final VoidCallback onClose;

  const FanSpeedEditView({
    required this.appState,
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseFieldEditView<FanSpeed>(
      title: "Fan Speed",
      value: appState.fanSpeed,
      onSave: (newValue) {
        appState.setFanSpeed(newValue);
        onClose();
      },
      onCancel: onClose,
      editorBuilder: (value, onChanged) {
        return EnumRadioSelector<FanSpeed>(
          options: FanSpeed.values,
          initialValue: value ?? appState.fanSpeed,
          displayStringForOption: (option) => option.displayName,
          onResult: (selected) => onChanged(selected),
        );
      },
    );
  }
}
