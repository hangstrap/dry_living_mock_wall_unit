import 'package:flutter/material.dart';
import 'humiditty_graph_widget.dart';

class HumidityEditWidget extends StatefulWidget {
  final int initialTargetHumidity;
  final ValueChanged<int> onChanged;
  final VoidCallback onCancel;

  const HumidityEditWidget({
    super.key,
    required this.initialTargetHumidity,
    required this.onChanged,
    required this.onCancel,
  });

  @override
  State<HumidityEditWidget> createState() => _HumidityEditWidgetState();
}

class _HumidityEditWidgetState extends State<HumidityEditWidget> {
  late int targetHumidity;

  @override
  void initState() {
    super.initState();
    targetHumidity = widget.initialTargetHumidity;
  }

  void _changeHumidity(int delta) {
    setState(() {
      targetHumidity =
          (targetHumidity + delta).clamp(HumidityGraphScaleHelper.minHumidity, HumidityGraphScaleHelper.maxHumidity);
    });
  }

  void _setFromGraph(int value) {
    setState(() {
      targetHumidity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        const Text(
          'Select Required Humidity',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: const Icon(Icons.chevron_left), onPressed: () => _changeHumidity(-1)),
            const SizedBox(width: 8),
            const Text('Humidity', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text('$targetHumidity%', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.chevron_right), onPressed: () => _changeHumidity(1)),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: HumidityGraphWidget(
            humidity: targetHumidity,
            targetHumidity: targetHumidity,
            onHumidityTap: _setFromGraph,
            onEditRequested: (){},
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: widget.onCancel, child: const Text('Cancel')),
            const SizedBox(width: 20),
            ElevatedButton(onPressed: () => widget.onChanged(targetHumidity), child: const Text('OK')),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
