import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'wall_unit/wall_unit_widget.dart';
import 'roof_unit_widet.dart';
import 'clock_widget.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
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
              WallUnitWidget(spaceBox: spaceBox, appState: roofUnitState),
              spaceBox,
              RoofUnitWidget(appState: roofUnitState),
              spaceBox,
              UserInputWidget(appState: roofUnitState),
              spaceBox,
              ClockWidget( time: roofUnitState.simulatedTime), 
            ],
          ),
        ),
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
          const SizedBox(height: 16), 
          Text("House humidity is : ${appState.humidity}"),
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
