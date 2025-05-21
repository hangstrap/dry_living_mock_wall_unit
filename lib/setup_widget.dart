import 'package:flutter/material.dart';
import 'app_state.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({
    super.key,
    required this.spaceBox,
    required this.appState,
  });

  final SizedBox spaceBox;
  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 360,
      color: Colors.grey[200],
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ModeEditWidget(appState: appState),
                spaceBox,
                FanSpeedEditWidget(appState: appState),
              ],
            ),
          ),
          spaceBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(Icons.reply),
                label: Text('home'),
                onPressed: () => appState.setDisplay(Display.home),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class ModeEditWidget extends StatelessWidget {
  const ModeEditWidget({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to the left
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Mode"),
            const SizedBox(width: 8),
              OutlinedButton(
              onPressed: () => appState.setEditing(Editing.mode),
              child: Text(appState.mode.name),
            ),
          ],
        ),
        if (appState.editing == Editing.mode)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RadioListTile<Mode>(
                title: const Text('Off'),
                value: Mode.off,
                groupValue: appState.mode,
                onChanged: (value) => appState.setMode(value!),
              ),
              RadioListTile<Mode>(
                title: const Text('Fan Only'),
                value: Mode.fanOnly,
                groupValue: appState.mode,
                onChanged: (value) => appState.setMode(value!),
              ),
              RadioListTile<Mode>(
                title: const Text('Fan and Dehumidifier'),
                value: Mode.humidifier,
                groupValue: appState.mode,
                onChanged: (value) => appState.setMode(value!),
              ),
            ],
          ),
      ],
    );
  }
}

class FanSpeedEditWidget extends StatelessWidget {
  const FanSpeedEditWidget({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Fan Speed"),
        SizedBox(width: 8),
        OutlinedButton(
          onPressed: () => {},
          child: Text(appState.fanSpeed.name),
        ),
      ],
    );
  }
}
