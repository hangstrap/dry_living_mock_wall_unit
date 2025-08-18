import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../app_state_extention.dart';
import 'base_field_edit_view.dart';

class ModeEditView extends StatelessWidget {
  final AppState appState;
   final VoidCallback onClose; 

  const ModeEditView({required this.appState,     required this.onClose, super.key});

  @override
  Widget build(BuildContext context) {
    return BaseFieldEditView<Mode>(
      title: "Select Mode",
      value: appState.mode,
      onSave: (newMode){ 
        appState.setMode(newMode);  
        onClose(); 
      },
      onCancel: onClose,
      editorBuilder: (value, onChanged) {
        return ListView(
          children: Mode.values.map((m) {
            return RadioListTile<Mode>(
              title: Text(m.displayName), // from your enum extension
              value: m,
              groupValue: value,
              onChanged: onChanged,
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8), // reduce vertical space
              visualDensity: VisualDensity(vertical: -4), // even more compact
            );
          }).toList(),
        );
      },
    );
  }
}
