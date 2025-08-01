import 'package:flutter/material.dart';
import 'app_state.dart';


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
                Icon(Icons.wind_power, color: appState.fanRelay ==FanRelay.off? Colors.blue: Colors.green),
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
                Icon(Icons.air_outlined, color: appState.externalVentRelay == ExternalVenRelay.closed?  Colors.blue: Colors.green),
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
                Icon(Icons.ac_unit, color: appState.deHumidifierRelay==DeHumidifierRelay.off? Colors.blue: Colors.green),
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
