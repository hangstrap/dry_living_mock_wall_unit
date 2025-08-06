import 'package:flutter/material.dart';

class ClockWidget extends StatelessWidget {
  final DateTime time;
  const ClockWidget({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
     //   color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            "$hour:$minute",
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ...existing code...

// class UserInputWidget extends StatelessWidget {
//   const UserInputWidget({super.key, required this.appState});

//   final AppState appState;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           Text("House humidity is : ${appState.humidity}"),
//           Slider(
//             value: appState.humidity.toDouble(),
//             min: 0,
//             max: 100,
//             divisions: 100,
//             label: appState.humidity.toString(),
//             onChanged: (value) => appState.setHumidity(value.toInt()),
//           ),
//           const SizedBox(height: 16),
//           ClockWidget(time: appState.simulatedTime),
//         ],
//       ),
//     );
//   }
// }
// ...existing