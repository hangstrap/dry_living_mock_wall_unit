import 'package:flutter/material.dart';
import '../app_state.dart';
import 'editors/mode_edit_view.dart';
import 'editors/external_vent_edit_view.dart';
import 'editors/target_humidity_edit_view.dart';
import 'editors/fan_speed_edit_view.dart';
import 'editing_field_enum.dart';
import 'wall_unit_edit_menu.dart';
import 'wall_unit_info_menu.dart';
import 'info/version_view_widget.dart';

class WallUnitFieldEditRouter extends StatelessWidget {
  final EditingField field;
  final AppState appState;
  final VoidCallback onClose;
  final SizedBox? spaceBox;
  final ValueChanged<EditingField>? onFieldSelected; // Add this

  const WallUnitFieldEditRouter({
    required this.field,
    required this.appState,
    required this.onClose,
    this.spaceBox,
    this.onFieldSelected, // Add this
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (field) {
      case EditingField.editMenu:
        return WallUnitEditMenu(
          appState: appState,
          spaceBox: spaceBox ?? const SizedBox(height: 12),
          onFieldSelected: onFieldSelected ?? (_) {},
          onBack: onClose,
        );
      case EditingField.infoMenu:
        return WallUnitInfoMenu(
          onBack: onClose,
          spaceBox: spaceBox ?? const SizedBox(height: 12),
          onFieldSelected: onFieldSelected ?? (_) {},
        );
      case EditingField.version:
        return VersionViewWidget(onClose: onClose);
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
