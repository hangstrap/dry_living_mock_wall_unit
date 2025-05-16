import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RoofUnitState(),
      child: const MainApp(),
    ),
  );
}

enum Mode { off, fanOnly, humidifier }

enum FanSpeed { low, auto, high }

enum ExternalVent { open, closed }

class RoofUnitState extends ChangeNotifier {
  Mode _mode = Mode.humidifier;
  FanSpeed _fanSpeed = FanSpeed.low;
  ExternalVent _externalVent = ExternalVent.closed;

  Mode get mode => _mode;
  void setMode(Mode mode) {
    _mode = mode;
    notifyListeners();
  }

  FanSpeed get fanSpeed => _fanSpeed;
  void setFanSpeed(FanSpeed speed) {
    _fanSpeed = speed;
    notifyListeners();
  }

  ExternalVent get externalVent => _externalVent;
  void setExternalVent(ExternalVent vent) {
    _externalVent = vent;
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static SizedBox spaceBox = SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    var roofUnitState = context.watch<RoofUnitState>();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 240,
            height: 320,
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

class ModeValueWidget extends StatelessWidget {
  const ModeValueWidget({super.key, required this.mode, required this.onTap});

  final Mode mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                displayMode(mode),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String displayMode(Mode mode) {
    switch (mode) {
      case Mode.off:
        return 'Unit Off';
      case Mode.fanOnly:
        return 'Only Fan Only';
      case Mode.humidifier:
        return 'Dehumidifier Idle';
    }
  }
}

class LabelValueWidget extends StatelessWidget {
  const LabelValueWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: Text(label)),
          ),
          SizedBox(width: 20), // optional spacing
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                captalise(value),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String captalise(String str) {
    return str[0].toUpperCase() + str.substring(1);
  }
}
