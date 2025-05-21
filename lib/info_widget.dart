import 'package:flutter/material.dart';
import 'app_state.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
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
          Expanded(child: Column(children: [Text("Info here")])),
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
