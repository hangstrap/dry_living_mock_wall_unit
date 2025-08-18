import 'package:flutter/material.dart';
import '../app_state.dart';
import 'wall_unit_field_edit_router.dart';
import "editing_field_enum.dart";
import 'wall_unit_settings_menu.dart';
import 'views/logo_and_company_widget.dart';
import 'views/mode_value_widget.dart';
import 'views/humidity_graph_widget.dart';

class WallUnitWidget extends StatefulWidget {
  final SizedBox spaceBox;
  final AppState appState;

  const WallUnitWidget({
    super.key,
    required this.spaceBox,
    required this.appState,
  });

  @override
  State<WallUnitWidget> createState() => _WallUnitWidgetState();
}

class _WallUnitWidgetState extends State<WallUnitWidget> {
  EditingField editing = EditingField.home;
  EditingField previousEditingField = EditingField.home;

  void _handleFieldSelected(EditingField field) {
    setState(() {
      previousEditingField = editing;
      editing = field;
    });
  }

  void _handleClose() {
    setState(() {
      editing = previousEditingField;
      // Optionally reset previousEditingField if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;
    final spaceBox = widget.spaceBox;

    if (editing == EditingField.home) {
      // Home UI
      return Container(
        width: 240,
        height: 360,
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const LogoAndCompany(),
                widget.spaceBox,
                ModeValueWidget(
                  text: appState.modalDisplay,
                  onTap: () => setState(() => editing = EditingField.mode),
                ),
                widget.spaceBox,
                Opacity(
                  opacity: appState.displayHumifity ? 1.0 : 0.0,
                  child: GestureDetector(
                    onTap: () {},
                    child: HumidityGraphWidget(
                      humidity: appState.humidity,
                      targetHumidity: appState.targetHumidity,
                      onHumidityTap: (_) {},
                      onEditRequested: () => setState(
                          () => editing = EditingField.targetHumidity),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => setState(() => editing = EditingField.editMenu),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    // Info action
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } else if (editing == EditingField.editMenu) {
      // Settings menu
      return WallUnitSettingsMenu(
        appState: appState,
        spaceBox: spaceBox,
        onFieldSelected: _handleFieldSelected,
        onBack: () => setState(() => editing = EditingField.home),
      );
    } else {
      // Edit screens
      return WallUnitFieldEditRouter(
        field: editing,
        appState: widget.appState,
        spaceBox: widget.spaceBox,
        onClose: _handleClose,
      );
    }
  }
}
