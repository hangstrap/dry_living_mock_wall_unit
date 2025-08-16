import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../app_state_extention.dart';
import 'base_field_edit_view.dart';

class ExternalVentEditView extends StatelessWidget {
  final AppState appState;
  const ExternalVentEditView({required this.appState, super.key});

  @override
  Widget build(BuildContext context) {
    return BaseFieldEditView<ExternalVent>(
      title: "External Vent",
      value: appState.externalVent,
      onSave: (newValue) => appState.setExternalVent(newValue),
      editorBuilder: (value, onChanged) => Column(
        children: ExternalVent.values
            .map(
              (e) => RadioListTile<ExternalVent>(
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
