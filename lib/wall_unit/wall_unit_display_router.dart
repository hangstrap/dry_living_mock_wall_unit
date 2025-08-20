import 'package:flutter/material.dart';
import '../app_state.dart';
import 'editors/mode_edit_view.dart';
import 'editors/external_vent_edit_view.dart';
import 'editors/target_humidity_edit_view.dart';
import 'editors/fan_speed_edit_view.dart';
import 'display_enum.dart';
import 'editors/wall_unit_edit_menu.dart';
import 'info/wall_unit_info_menu.dart';
import 'info/version_view_widget.dart';

class WallUnitDisplayRouter extends StatelessWidget {
  final DisplayEnum field;
  final AppState appState;
  final VoidCallback onClose;
  final SizedBox? spaceBox;
  final ValueChanged<DisplayEnum>? onFieldSelected; // Add this

  const WallUnitDisplayRouter({
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
      case DisplayEnum.editMenu:
        return WallUnitEditMenu(
          appState: appState,
          spaceBox: spaceBox ?? const SizedBox(height: 12),
          onFieldSelected: onFieldSelected ?? (_) {},
          onBack: onClose,
        );
      case DisplayEnum.infoMenu:
        return WallUnitInfoMenu(
          onBack: onClose,
          spaceBox: spaceBox ?? const SizedBox(height: 12),
          onFieldSelected: onFieldSelected ?? (_) {},
        );
      case DisplayEnum.version:
        return VersionViewWidget(onClose: onClose);
      case DisplayEnum.mode:
        return ModeEditView(appState: appState, onClose: onClose);
      case DisplayEnum.fanSpeed:
        return FanSpeedEditView(appState: appState, onClose: onClose);
      case DisplayEnum.externalVent:
        return ExternalVentEditView(appState: appState, onClose: onClose);
      case DisplayEnum.targetHumidity:
        return TargetHumidityEditView(appState: appState, onClose: onClose);
      default:
        throw UnimplementedError('Field $field is not implemented');
    }
  }
}
