import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../views/humidity_graph_widget.dart';
import 'base_field_edit_view.dart';

class TargetHumidityEditView extends StatefulWidget {
  final AppState appState;
  final VoidCallback onClose;
  const TargetHumidityEditView({
    required this.appState,
    required this.onClose,
    super.key,
  });

  @override
  State<TargetHumidityEditView> createState() => _TargetHumidityEditViewState();
}

class _TargetHumidityEditViewState extends State<TargetHumidityEditView> {
  late int targetHumidity;

  @override
  void initState() {
    super.initState();
    targetHumidity = widget.appState.targetHumidity;
  }



  @override
  Widget build(BuildContext context) {
    return BaseFieldEditView<int>(
      title: "Target Humidity",
      value: targetHumidity,
      onSave: (newValue) {
        widget.appState.setTargetHumidity(newValue);
        widget.onClose();
      },
      onCancel: widget.onClose,
      editorBuilder: (value, onChanged) {
        final displayValue = value ?? targetHumidity;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {
                  final newVal = (displayValue - 1)
                      .clamp(HumidityGraphScaleHelper.minHumidity, HumidityGraphScaleHelper.maxHumidity);
                  onChanged(newVal);
                }),
                const SizedBox(width: 8),
                Text('$displayValue%', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {
                  final newVal = (displayValue + 1)
                      .clamp(HumidityGraphScaleHelper.minHumidity, HumidityGraphScaleHelper.maxHumidity);
                  onChanged(newVal);
                }),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: HumidityGraphWidget(
                humidity: displayValue,
                targetHumidity: displayValue,
                onHumidityTap: (v) => onChanged(v),
                onEditRequested: () {},
                dislayLable: false,
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}
