import 'package:flutter/material.dart';
import 'app_state.dart';

extension RelayColors on AppState {

  Color get powerColor {
    if (powerRelay == PowerRelay.off) return Colors.grey;
    return Colors.red;
  }

  Color get fanColor {
    if (powerRelay == PowerRelay.off) return Colors.grey;
    if (fanRelay == FanRelay.low) return Colors.blue;
    return Colors.green;
  }
  Color get externalVentColor {
    if (powerRelay == PowerRelay.off) return Colors.grey;
    if (externalVentRelay == ExternalVenRelay.closed ) return Colors.blue;
    return Colors.green;
  }
  Color get dehumidifierColor{
    if (powerRelay == PowerRelay.off) return Colors.grey;
    if (deHumidifierRelay == DeHumidifierRelay.off ) return Colors.blue;
    return Colors.green;

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
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          _buildStatusButton(
            icon: Icons.wind_power,
            color: appState.powerColor,
            label: "Power ${appState.powerRelay.name}", 
          ),
          _buildStatusButton(
            icon: Icons.wind_power,
            color:  appState.fanColor,
            label: "Fan ${appState.fanRelay.name}",
          ),
          _buildStatusButton(
            icon: Icons.air_outlined,
            color: appState.externalVentColor,
            label: "Vent ${appState.externalVentRelay.name}",
          ),
          _buildStatusButton(
            icon: Icons.ac_unit,
            color: appState.dehumidifierColor,
            label: "Dehumidifier ${appState.deHumidifierRelay.name}",
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
