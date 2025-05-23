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
          LogoAndCompany(),
          spaceBox,
          ModeValueWidget(
            appState: appState,
            onTap: () => appState.toggleMode(),
          ),
          spaceBox,
          Opacity(
            opacity: appState.displayFanSpeed ? 1.0 : 0.0,
            child: LabelValueWidget(
              label: 'Fan Speed',
              value: appState.fanSpeed.name,
              onTap: () => appState.toggleFanSpeed(),
            ),
          ),
          spaceBox,
          Opacity(
            opacity: appState.displayExternalVent ? 1.0 : 0.0,
            child: LabelValueWidget(
              label: 'External Vent',
              value: appState.externalVent.name,
              onTap: () => appState.toggleExternalVent(),
            ),
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
          //          spaceBox,
          Opacity(
            opacity: appState.displayHumifity ? 1.0 : 0.0,
            child: HumidityGraphWidget(
              humidity: appState.humidity,
              targetHumidity: appState.targetHumidity,
              onHumidityTap: (value) => appState.setTargetHumidity(value),
            ),
          ),
        ],
      ),
    );
  }
}

