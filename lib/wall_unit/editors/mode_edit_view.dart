import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../app_state_extention.dart';
import 'base_field_edit_view.dart';
import 'enum_radio_selector.dart';

class ModeEditView extends StatelessWidget {
  final AppState appState;
  final VoidCallback onClose;

  const ModeEditView({
    required this.appState,
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseFieldEditView<Mode>(
      title: "Select Mode",
      value: appState.mode,
      onSave: (newMode) {
        appState.setMode(newMode);
        onClose();
      },
      onCancel: onClose,
      editorBuilder: (value, onChanged) {
        return EnumRadioSelector<Mode>(
          options: Mode.values,
          initialValue: value ?? appState.mode,
          displayStringForOption: (option) => option.displayName,
          onResult: (selected) => onChanged(selected),
        );
      },
    );
  }
}
