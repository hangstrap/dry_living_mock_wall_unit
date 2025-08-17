import 'package:flutter/material.dart';
import '../app_state.dart';
import 'views/logo_and_company_widget.dart';
import 'views/mode_value_widget.dart';
import 'views/humidity_graph_widget.dart';
import 'wall_unit_field_edit_router.dart';
import 'wall_unit_settings_menu.dart';
import "editing_field_enum.dart";



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
  EditingField? editing;

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;
    final spaceBox = widget.spaceBox;
    // Field editor view
    if (editing != null && editing != EditingField.menu) {
      return WallUnitFieldEditRouter(field: editing!, 
      appState: appState,
      onClose: ()=> setState(()=>editing=null));
    }

    // Menu view
    if (editing == EditingField.menu) {
      return Container(
        width: 240,
        height: 360,
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WallUnitSettingsMenu(
              appState: appState,
              spaceBox: spaceBox,
              onFieldSelected: (field) => setState(() => editing = field),
              onBack: ()=> setState(() => editing = null),
            )
          ],
        ),
      );
    }

    // Top display view
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
                  onTap: () {}, // Top view tap does nothing
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
                onPressed: () => setState(() => editing = EditingField.menu),
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
  }

}
