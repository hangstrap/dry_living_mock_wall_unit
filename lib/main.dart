import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'wall_unit_widgit.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppState())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static SizedBox spaceBox = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    var roofUnitState = context.watch<AppState>();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WallUnitWidgit(spaceBox: spaceBox, appState: roofUnitState),
              spaceBox,
              RoofUnitWidget(appState: roofUnitState),
              spaceBox,
              UserInputWidget(appState: roofUnitState),
            ],
          ),
        ),
      ),
    );
  }
}

class RoofUnitWidget extends StatelessWidget {
  const RoofUnitWidget({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                Text("Fan ${appState.fanRelay.name}"),
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
                Text("Vent ${appState.externalVentRelay.name}"),
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
                Text("Dehumidifier ${appState.deHumidifierRelay.name}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserInputWidget extends StatelessWidget {
  const UserInputWidget({super.key, required this.appState});

  final AppState appState;
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
                value: appState.externalVentPresent,
                onChanged:
                    (value) => {
                      if (value != null)
                        {appState.setExternalVentPresent(value)},
                    },
              ),
              const Text("External Vent Present"),
            ],
          ),
          const SizedBox(height: 16), 
          Text("Value: ${appState.humidity}"),
          Slider(
            value: appState.humidity.toDouble(),
            min: 0,
            max: 100,
            divisions: 100,
    
            label: appState.humidity.toString(),
            onChanged: (value) => appState.setHumidity(value.toInt()),
          ),
        ],
      ),
    );
  }
}
