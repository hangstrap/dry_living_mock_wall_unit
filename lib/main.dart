  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'label_value_widget.dart';
import 'mode_value_widget.dart';
import 'roof_unit_state.dart';
import 'humiditty_graph_widget.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RoofUnitState(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static SizedBox spaceBox = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    var roofUnitState = context.watch<RoofUnitState>();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
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
          ),
        ),
      ),
    );
  }
}

class LogoAndCompany extends StatelessWidget {
  const LogoAndCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            //height: 40,
            child: Image.asset(
              'assets/dry_living_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Dehumidifier Ventilation System',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
