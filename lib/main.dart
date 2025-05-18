import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'roof_unit_state.dart';
import 'wall_unit_widgit.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoofUnitState()),
        ChangeNotifierProvider(create: (_) => UserInputState()),
      ],
      child: const MainApp(),
    ),
  );
}

class UserInputState extends ChangeNotifier {
  bool _externalVentPresent = false;
  int _humidity = 50;

  bool get externalVentPresent => _externalVentPresent;
  int get humidity => _humidity;

  void setExternalVentPresent(bool? value) {
    _externalVentPresent = value ?? false;
    notifyListeners();
  }

  void setHumidity(int value) {
    _humidity = value;
    notifyListeners();
  }
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static SizedBox spaceBox = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    var roofUnitState = context.watch<RoofUnitState>();
    var userInputState = context.watch<UserInputState>();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WallUnitWidgit(spaceBox: spaceBox, roofUnitState: roofUnitState),
              spaceBox,
              RoofUnitWidget(roofUnitState: roofUnitState),
              spaceBox,
              UserInputWidget( userInputState: userInputState),
            ],
          ),
        ),
      ),
    );
  }
}

class RoofUnitWidget extends StatelessWidget {
  const RoofUnitWidget({super.key, required this.roofUnitState});

  final RoofUnitState roofUnitState;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.wind_power, color: Colors.blue),
                SizedBox(width: 4),
                Text("Fan ${roofUnitState.fanSpeed.name}"),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.air_outlined, color: Colors.blue),
                SizedBox(width: 4),
                Text("Vent ${roofUnitState.externalVent.name}"),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.ac_unit, color: Colors.blue),
                SizedBox(width: 4),
                Text("Dehumidifier running"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserInputWidget extends StatelessWidget {
  const UserInputWidget({super.key, required this.userInputState});

  final UserInputState userInputState;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: userInputState.externalVentPresent,
                onChanged: userInputState.setExternalVentPresent,
              ),
              const Text("External Vent Present"),
            ],
          ),
          const SizedBox(height: 16),
          Text("Value: ${userInputState.humidity}"),
          Slider(
            value: userInputState.humidity.toDouble(),
            min: 0,
            max: 100,
            divisions: 10,
            label: userInputState.humidity.toString(),
            onChanged:(value)=> userInputState.setHumidity( value.toInt() ),
          ),
        ],
      ),
    );
  }
}
