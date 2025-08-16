import 'package:flutter/material.dart';
import '../../app_state.dart';
import 'humidity_edit_widget.dart';
import 'base_field_edit_view.dart';



class TargetHumidityEditView extends StatelessWidget {
  final AppState appState;
  const TargetHumidityEditView({required this.appState, super.key});

  @override
  Widget build(BuildContext context) {
    return BaseFieldEditView<int>(
      title: "Target Humidity",
      value: appState.targetHumidity,
      onSave: (newValue) => appState.setTargetHumidity(newValue),
      editorBuilder: (value, onChanged) {
        // coerce nullable int? to non-nullable int
        final nonNullValue = value ?? appState.targetHumidity;

        return HumidityEditWidget(
          initialTargetHumidity: nonNullValue,
          onChanged: (v) => onChanged(v),
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }
}