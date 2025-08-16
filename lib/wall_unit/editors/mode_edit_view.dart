import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../app_state_extention.dart';
import 'base_field_edit_view.dart';

class ModeEditView extends StatelessWidget {
  final AppState appState;
  const ModeEditView({required this.appState, super.key});

  @override
  Widget build(BuildContext context) {
    return BaseFieldEditView<Mode>(
      title: "Select Mode",
      value: appState.mode,
      onSave: (newMode) => appState.setMode(newMode),
      editorBuilder: (value, onChanged) {
        return ListView(
          children: Mode.values.map((m) {
            return RadioListTile<Mode>(
              title: Text(m.displayName), // from your enum extension
              value: m,
              groupValue: value,
              onChanged: onChanged,
            );
          }).toList(),
        );
      },
    );
  }
}
