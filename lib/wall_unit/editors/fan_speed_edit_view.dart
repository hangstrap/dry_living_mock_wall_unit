import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../app_state_extention.dart';
import 'base_field_edit_view.dart';

class FanSpeedEditView extends StatelessWidget {
  final AppState appState;
  const FanSpeedEditView({required this.appState, super.key});

  @override
  Widget build(BuildContext context) {
    return BaseFieldEditView<FanSpeed>(
      title: "Fan Speed",
      value: appState.fanSpeed,
      onSave: (newValue) => appState.setFanSpeed( newValue),
      editorBuilder: (value, onChanged) => Column(
        children: FanSpeed.values
            .map(
              (e) => RadioListTile<FanSpeed>(
                title: Text(e.displayName),
                value: e,
                groupValue: value,
                onChanged: onChanged,
              ),
            )
            .toList(),
      ),
    );
  }
}
