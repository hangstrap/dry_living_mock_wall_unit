import 'package:flutter/material.dart';
import 'app_state.dart';
import 'label_value_widget.dart';
import 'mode_value_widget.dart';
import 'humiditty_graph_widget.dart';
import 'logo_and_company_widget.dart';
import 'enum_radio_selector.dart';

class WallUnitWidgit extends StatefulWidget {
  const WallUnitWidgit({
    super.key,
    required this.spaceBox,
    required this.appState,
  });

  final SizedBox spaceBox;
  final AppState appState;

  @override
  State<WallUnitWidgit> createState() => _WallUnitWidgitState();
}

enum EditingField { fanSpeed, externalVent }

class _WallUnitWidgitState extends State<WallUnitWidgit> {
  EditingField? editing;
  FanSpeed? tempFanSpeed;
  ExternalVent? tempExternalVent;

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;

    if (editing != null) {
      return Container(
        width: 240,
        height: 360,
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const LogoAndCompany(),
            widget.spaceBox,
            if (editing == EditingField.fanSpeed)
              EnumRadioSelector<FanSpeed>(
                title: 'Select Fan Speed',
                options: FanSpeed.values,
                initialValue: tempFanSpeed ?? FanSpeed.low,
                displayStringForOption: (val) => val.toString(),
                onResult: (val) => setState(() => tempFanSpeed = val),
              ),
            if (editing == EditingField.externalVent)
              ...ExternalVent.values.map(
                (vent) => RadioListTile<ExternalVent>(
                  title: Text(vent.name),
                  value: vent,
                  groupValue: tempExternalVent,
                  onChanged: (val) => setState(() => tempExternalVent = val),
                ),
              ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => setState(() => editing = null),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (editing == EditingField.fanSpeed &&
                        tempFanSpeed != null) {
                      appState.setFanSpeed(tempFanSpeed!);
                    } else if (editing == EditingField.externalVent &&
                        tempExternalVent != null) {
                      appState.setExternalVent(tempExternalVent!);
                    }
                    setState(() => editing = null);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      width: 240,
      height: 360,
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const LogoAndCompany(),
          widget.spaceBox,
          ModeValueWidget(
            appState: appState,
            onTap: () => appState.toggleMode(),
          ),
          widget.spaceBox,
          Opacity(
            opacity: appState.displayFanSpeed ? 1.0 : 0.0,
            child: LabelValueWidget(
              label: 'Fan Speed',
              value: appState.fanSpeed.name,
              onTap:
                  () => setState(() {
                    editing = EditingField.fanSpeed;
                    tempFanSpeed = appState.fanSpeed;
                  }),
            ),
          ),
          widget.spaceBox,
          Opacity(
            opacity: appState.displayExternalVent ? 1.0 : 0.0,
            child: LabelValueWidget(
              label: 'External Vent',
              value: appState.externalVent.name,
              onTap:
                  () => setState(() {
                    editing = EditingField.externalVent;
                    tempExternalVent = appState.externalVent;
                  }),
            ),
          ),
          widget.spaceBox,
          Opacity(
            opacity: appState.displayHumifity ? 1.0 : 0.0,
            child: LabelValueWidget(
              label: 'Humidity',
              value: '${appState.humidity}%',
              onTap: () {},
            ),
          ),
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
