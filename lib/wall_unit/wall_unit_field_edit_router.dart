import 'package:flutter/material.dart';
import '../app_state.dart';
import 'editors/mode_edit_view.dart';
import 'editors/external_vent_edit_view.dart';
import 'editors/target_humidity_edit_view.dart';
import 'editors/fan_speed_edit_view.dart';
import 'editing_field_enum.dart';
import 'wall_unit_settings_menu.dart';



class WallUnitFieldEditRouter extends StatelessWidget {
  final EditingField field;
  final AppState appState;
  final VoidCallback onClose;
  final SizedBox? spaceBox; // Needed for menu/home

  const WallUnitFieldEditRouter({
    required this.field,
    required this.appState,
    required this.onClose,
    this.spaceBox,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (field) {
      case EditingField.editMenu:
        return WallUnitSettingsMenu(
          appState: appState,
          spaceBox: spaceBox ?? const SizedBox(height: 12),
          onFieldSelected: (f) => onClose(), // You may want to handle this differently
          onBack: onClose,
        );
      case EditingField.mode:
        return ModeEditView(appState: appState, onClose: onClose);
      case EditingField.fanSpeed:
        return FanSpeedEditView(appState: appState, onClose: onClose);
      case EditingField.externalVent:
        return ExternalVentEditView(appState: appState, onClose: onClose);
      case EditingField.targetHumidity:
        return TargetHumidityEditView(appState: appState, onClose: onClose);
      default:
        throw UnimplementedError('Field $field is not implemented');
    }
  }
}