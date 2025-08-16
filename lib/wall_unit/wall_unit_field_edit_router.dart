import 'package:flutter/material.dart';
import '../app_state.dart';
import 'editors/mode_edit_view.dart';
import 'editors/external_vent_edit_view.dart';
import 'editors/target_humidity_edit_view.dart';
import 'editors/fan_speed_edit_view.dart';
import 'editing_field_enum.dart';


class WallUnitFieldEditRouter extends StatelessWidget {
  final EditingField field;
  final AppState appState;
  const WallUnitFieldEditRouter({
    required this.field,
    required this.appState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (field) {
      case EditingField.mode:
        return ModeEditView(appState: appState);
      case EditingField.fanSpeed:
        return FanSpeedEditView(appState: appState);
      case EditingField.externalVent:
        return ExternalVentEditView(appState: appState);
      case EditingField.targetHumidity:
        return TargetHumidityEditView(appState: appState);
      default:
        throw Exception("Unsupported field: $field");    }
  }
}