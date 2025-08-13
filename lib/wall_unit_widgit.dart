import 'package:flutter/material.dart';
import 'app_state.dart';
import 'label_value_widget.dart';
import 'mode_value_widget.dart';
import 'humidity_graph_widget.dart';
import 'logo_and_company_widget.dart';
import 'enum_radio_selector.dart';
import 'humidity_edit_widget.dart';

class WallUnitWidget extends StatefulWidget {
  const WallUnitWidget({
    super.key,
    required this.spaceBox,
    required this.appState,
  });

  final SizedBox spaceBox;
  final AppState appState;

  @override
  State<WallUnitWidget> createState() => _WallUnitWidgetState();
}

enum EditingField { fanSpeed, externalVent, mode, targetHumidity }

class _WallUnitWidgetState extends State<WallUnitWidget> {
  EditingField? editing;

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;

    return editing != null
        ? _buildEditingView(appState)
        : _buildDisplayView(appState);
  }

  Widget _buildEditingView(AppState appState) {
    Widget? editor;

    switch (editing) {
      case EditingField.fanSpeed:
        editor = EnumRadioSelector<FanSpeed>(
          title: 'Select Fan Speed',
          options: FanSpeed.values,
          initialValue: appState.fanSpeed,
          displayStringForOption: (fs) => switch (fs) {
            FanSpeed.low => "Low",
            FanSpeed.auto => "Auto",
            FanSpeed.high => "High",
          },
          onResult: (selected) {
            setState(() {
              appState.setFanSpeed(selected);
              editing = null;
            });
          },
        );
        break;

      case EditingField.externalVent:
        editor = EnumRadioSelector<ExternalVent>(
          title: 'Select External Vent',
          options: ExternalVent.values,
          initialValue: appState.externalVent,
          displayStringForOption: (ev) => switch (ev) {
            ExternalVent.open => "Open",
            ExternalVent.closed => "Closed",
          },
          onResult: (selected) {
            setState(() {
              appState.setExternalVent(selected);
              editing = null;
            });
          },
        );
        break;

      case EditingField.mode:
        editor = EnumRadioSelector<Mode>(
          title: 'Select Mode',
          options: Mode.values,
          initialValue: appState.mode,
          displayStringForOption: (m) => switch (m) {
            Mode.off => "Off",
            Mode.fanOnly => "Fan Only",
            Mode.humidifierAndFan => "Dehumidifier and Fan",
            Mode.humidifierOnly => "Dehumidifier Only",
          },
          onResult: (selected) {
            setState(() {
              appState.setMode(selected);
              editing = null;
            });
          },
        );
        break;

      case EditingField.targetHumidity:
        editor = HumidityEditWidget(
          initialTargetHumidity: appState.targetHumidity,
          onCancel: () => setState(() => editing = null),
          onChanged: (newHumidity) {
            appState.setTargetHumidity(newHumidity);
            setState(() => editing = null);
          },
        );
        break;

      case null:
        break;
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
          if (editor != null) editor,
        ],
      ),
    );
  }

  Widget _buildDisplayView(AppState appState) {
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
            onTap: () => setState(() => editing = EditingField.mode),
          ),
          widget.spaceBox,
          Opacity(
            opacity: appState.displayFanSpeed ? 1.0 : 0.0,
            child: LabelValueWidget(
              label: 'Fan Speed',
              value: appState.fanSpeed.name,
              onTap: () => setState(() => editing = EditingField.fanSpeed),
            ),
          ),
          widget.spaceBox,
          Opacity(
            opacity: appState.displayExternalVent ? 1.0 : 0.0,
            child: LabelValueWidget(
              label: 'External Vent',
              value: appState.externalVent.name,
              onTap: () => setState(() => editing = EditingField.externalVent),
            ),
          ),
          widget.spaceBox,
          Opacity(
            opacity: appState.displayHumifity ? 1.0 : 0.0,
            child: GestureDetector(
              onTap: () => setState(() => editing = EditingField.targetHumidity),
              child: HumidityGraphWidget(
                humidity: appState.humidity,
                targetHumidity: appState.targetHumidity,
                onHumidityTap: (_) {},
                onEditRequested: () =>
                    setState(() => editing = EditingField.targetHumidity),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
