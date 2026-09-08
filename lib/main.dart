import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'wall_unit/wall_unit_widget.dart';
import 'roof_unit_widget.dart';
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
  static const double fontSize = 16;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'FreeSans',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: fontSize, fontFamily: 'FreeSans'),
          bodySmall: TextStyle(fontSize: fontSize, fontFamily: 'FreeSans'),
          titleLarge: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontFamily: 'FreeSans',
          ),
        ),
      ),
      home: const _MainScaffold(),
    );
  }
}

class _MainScaffold extends StatelessWidget {
  const _MainScaffold();
  static final SizedBox spaceBox = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final roofUnitState = context.watch<AppState>();

    return Scaffold(
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
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => _ClockEditDialog(
                    appState: roofUnitState,
                    initialTime: roofUnitState.simulatedTime,
                  ),
                );
              },
              child: ClockWidget(time: roofUnitState.simulatedTime),
            ),
          ],
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

class _ClockEditDialog extends StatefulWidget {
  final AppState appState;
  final DateTime initialTime;

  const _ClockEditDialog({required this.appState, required this.initialTime});

  @override
  State<_ClockEditDialog> createState() => _ClockEditDialogState();
}

class _ClockEditDialogState extends State<_ClockEditDialog> {
  late int hour;
  late int minute;

  @override
  void initState() {
    super.initState();
    hour = widget.initialTime.hour;
    minute = widget.initialTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Time'),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SpinnerColumn(
            value: hour,
            onIncrement: () => setState(() => hour = (hour + 1) % 24),
            onDecrement: () => setState(() => hour = (hour - 1 + 24) % 24),
            label: hour.toString().padLeft(2, '0'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(':', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          _SpinnerColumn(
            value: minute,
            onIncrement: () => setState(() => minute = (minute + 1) % 60),
            onDecrement: () => setState(() => minute = (minute - 1 + 60) % 60),
            label: minute.toString().padLeft(2, '0'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final now = widget.appState.simulatedTime;
            widget.appState.setSimulatedTime(
              DateTime(now.year, now.month, now.day, hour, minute, 0),
            );
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class _SpinnerColumn extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final String label;

  const _SpinnerColumn({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(icon: const Icon(Icons.expand_less), onPressed: onIncrement),
        Text(label, style: const TextStyle(fontSize: 28, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
        IconButton(icon: const Icon(Icons.expand_more), onPressed: onDecrement),
      ],
    );
  }
}
