import 'package:flutter/material.dart';
import 'app_state.dart';
import 'label_value_widget.dart';
import 'mode_value_widget.dart';
import 'humiditty_graph_widget.dart';
import 'logo_and_company_widget.dart';
import 'enum_radio_selector.dart';
import 'humidity_edit_widget.dart';

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

enum EditingField { fanSpeed, externalVent, mode, targetHumidity }

class _WallUnitWidgitState extends State<WallUnitWidgit> {
  EditingField? editing;
  //  FanSpeed? tempFanSpeed;
  //  ExternalVent? tempExternalVent;
  bool showFanSelector = false;

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
                initialValue: appState.fanSpeed,
                displayStringForOption: (fs){
                  switch(fs){
                    case FanSpeed.low: return "Low";
                    case FanSpeed.auto: return "Auto";
                    case FanSpeed.high: return "High";
                  }
                },
                onResult: (selected) {
                  setState(() {
                    appState.setFanSpeed(selected);
                    editing = null;
                  });
                },
              ),
            if (editing == EditingField.externalVent)
              EnumRadioSelector<ExternalVent>(
                title: 'Select External Vent',
                options: ExternalVent.values,
                initialValue: widget.appState.externalVent,
                displayStringForOption: (ev) {
                  switch( ev){
                    case ExternalVent.open: return "Open";
                    case ExternalVent.closed: return "Closed";
                  }
                },
                onResult: (selected) {
                  setState(() {
                    widget.appState.setExternalVent(selected);
                    editing = null;
                  });
                },
              ),

            if (editing == EditingField.mode)
              EnumRadioSelector<Mode>(
                title: 'Select Mode',
                options: Mode.values,
                initialValue: appState.mode,
                displayStringForOption: (m){
                    switch(m){
                      case Mode.off: return "Off";
                      case Mode.fanOnly: return "Fan Only";
                      case Mode.humidifier: return "Dehumidifier";
                    }
                  },
                onResult: (selected) {
                  setState(() {
                    appState.setMode(selected);
                    editing = null;
                  });
                },
              ),
            if (editing == EditingField.targetHumidity)
              HumidityEditWidget(
                initialTargetHumidity: appState.targetHumidity,
                onCancel: () => setState(() => editing = null),
                onChanged: (newHumidity) {
                  appState.setTargetHumidity(newHumidity);
                  setState(() => editing = null);
                },
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
            text: appState.modalDisplay,
            onTap:
                () => setState(() {
                  editing = EditingField.mode;
                }),
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
                  }),
            ),
          ),
          widget.spaceBox,

          Opacity(
            opacity: appState.displayHumifity ? 1.0 : 0.0,
            child: GestureDetector(
              onTap:
                  () => setState(() => editing = EditingField.targetHumidity),
              child: HumidityGraphWidget(
                humidity: appState.humidity,
                targetHumidity: appState.targetHumidity,
                onHumidityTap: (_) {}, // no-op when not editing
                onEditRequested: () {
                  setState(() {
                    editing = EditingField.targetHumidity;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
