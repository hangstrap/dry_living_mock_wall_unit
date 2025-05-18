import 'package:flutter/material.dart' ;
import 'roof_unit_state.dart';
import 'label_value_widget.dart';
import 'mode_value_widget.dart';
import 'humiditty_graph_widget.dart';
import 'logo_and_company_widget.dart';

class WallUnitWidgit extends StatelessWidget {
  const WallUnitWidgit({
    super.key,
    required this.spaceBox,
    required this.roofUnitState,
  });

  final SizedBox spaceBox;
  final RoofUnitState roofUnitState;

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
            mode: roofUnitState.mode,
            onTap: () {
              roofUnitState.setMode(
                roofUnitState.mode == Mode.off
                    ? Mode.humidifier
                    : Mode.off,
              );
            },
          ),
          spaceBox,
          LabelValueWidget(
            label: 'Fan Speed',
            value: roofUnitState.fanSpeed.name,
            onTap: () {
              roofUnitState.setFanSpeed(
                roofUnitState.fanSpeed == FanSpeed.low
                    ? FanSpeed.high
                    : FanSpeed.low,
              );
            },
          ),
          spaceBox,
          LabelValueWidget(
            label: 'External Vent',
            value: roofUnitState.externalVent.name,
            onTap: () {
              roofUnitState.setExternalVent(
                roofUnitState.externalVent == ExternalVent.closed
                    ? ExternalVent.open
                    : ExternalVent.closed,
              );
            },
          ),
          spaceBox,
          LabelValueWidget(
            label: 'Humidity',
            value: "${roofUnitState.humidity}%",
            onTap: () {
              roofUnitState.setHumidity(roofUnitState.humidity + 1);
            },
          ),
          spaceBox,
          HumidityGraphWidget(humidity: roofUnitState.humidity, targetHumidity: roofUnitState.targetHumidity),
        ],
      ),
    );
  }
}
