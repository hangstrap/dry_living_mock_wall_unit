import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../app_state_extention.dart';
import 'base_field_edit_view.dart';

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
      editorBuilder:
          (value, onChanged) => Column(
            children:
                ExternalVent.values
                    .map(
                      (e) => RadioListTile<ExternalVent>(
                        title: Text(e.displayName),
                        value: e,
                        groupValue: value,
                        onChanged: onChanged,
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 8,
                        ), // reduce vertical space
                        visualDensity: VisualDensity(
                          vertical: -4,
                        ), // even more compact
                      ),
                    )
                    .toList(),
          ),
    );
  }
}
