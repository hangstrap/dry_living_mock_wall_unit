import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../app_state_extention.dart';
import 'base_field_edit_view.dart';
import 'enum_radio_selector.dart';

class ExternalVentEditView extends StatelessWidget {
  final AppState appState;
  final VoidCallback onClose;

  const ExternalVentEditView({
    required this.appState,
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseFieldEditView<ExternalVent>(
      title: "External Vent",
      value: appState.externalVent,
      onSave: (newValue) {
        appState.setExternalVent(newValue);
        onClose();
      },
      onCancel: onClose,
      editorBuilder: (value, onChanged) {
        return EnumRadioSelector<ExternalVent>(
          options: ExternalVent.values,
          initialValue: value ?? appState.externalVent,
          displayStringForOption: (option) => option.displayName,
          onResult: (selected) => onChanged(selected),
        );
      },
    );
  }
}
