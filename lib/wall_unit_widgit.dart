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
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: const Text("Humidity"),
                    ),
                  ),
                  SizedBox(width: 20), // optional spacing
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: NumberPicker(
                        value: appState.targetHumidity,
                        onChanged: appState.setTargetHumidity,
                        min: 20,
                        max: 80,
                      ),
                    ),
                  ),
                ],
              ),
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

class NumberPicker extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final void Function(int) onChanged;

  const NumberPicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: value > min ? () => onChanged(value - 1) : null,
        ),
        Text('$value', style: const TextStyle(fontSize: 10)),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: value < max ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
}
