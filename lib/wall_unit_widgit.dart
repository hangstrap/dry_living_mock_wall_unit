import 'package:flutter/material.dart';
import 'app_state.dart';
import 'label_value_widget.dart';
import 'mode_value_widget.dart';
import 'humiditty_graph_widget.dart';
import 'logo_and_company_widget.dart';

class WallUnitWidgit extends StatelessWidget {
  const WallUnitWidgit({
    super.key,
    required this.spaceBox,
    required this.appState,
  });

  final SizedBox spaceBox;
  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 360,
      color: Colors.grey[200],
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                LogoAndCompany(),
                spaceBox,
                ModeValueWidget(
                  appState: appState,
                  onTap: () => appState.toggleMode(),
                ),
                spaceBox,
                Opacity(
                  opacity: appState.displayHumifity ? 1.0 : 0.0,
                  child: LabelValueWidget(
                    label: 'Humidity',
                    value: '${appState.humidity}%',
                    onTap: () => {},
                  ),
                ),
                Opacity(
                  opacity: appState.displayHumifity ? 1.0 : 0.0,
                  child: HumidityGraphWidget(
                    humidity: appState.humidity,
                    targetHumidity: appState.targetHumidity,
                    onHumidityTap:
                        (v) =>
                            {}, //(value) => appState.setTargetHumidity(value),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Setup'),
                onPressed: () => appState.setDisplay(Display.settings),
              ),
              SizedBox(width: 16),
              TextButton.icon(
                icon: Icon(Icons.info),
                label: Text('Info'),
                onPressed: () => appState.setDisplay(Display.info),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
