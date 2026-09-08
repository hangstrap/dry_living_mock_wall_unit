import 'package:flutter/material.dart';
import '../../app_state.dart';
import 'base_field_edit_view.dart';

class ClockEditView extends StatefulWidget {
  final AppState appState;
  final VoidCallback onClose;

  const ClockEditView({
    required this.appState,
    required this.onClose,
    super.key,
  });

  @override
  State<ClockEditView> createState() => _ClockEditViewState();
}

class _ClockEditViewState extends State<ClockEditView> {
  late int hour;
  late int minute;

  @override
  void initState() {
    super.initState();
    hour = widget.appState.simulatedTime.hour;
    minute = widget.appState.simulatedTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    // Pack hour and minute into a single int for BaseFieldEditView:
    // value = hour * 60 + minute
    final packedInitial = hour * 60 + minute;

    return BaseFieldEditView<int>(
      title: 'Set Time',
      value: packedInitial,
      onSave: (packed) {
        final h = packed ~/ 60;
        final m = packed % 60;
        final now = widget.appState.simulatedTime;
        widget.appState.setSimulatedTime(
          DateTime(now.year, now.month, now.day, h, m, 0),
        );
        widget.onClose();
      },
      onCancel: widget.onClose,
      editorBuilder: (packed, onChanged) {
        final h = (packed ?? packedInitial) ~/ 60;
        final m = (packed ?? packedInitial) % 60;

        void changeHour(int delta) {
          final newH = (h + delta) % 24;
          onChanged(newH * 60 + m);
        }

        void changeMinute(int delta) {
          final newM = (m + delta + 60) % 60;
          onChanged(h * 60 + newM);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hour picker
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.expand_less),
                      onPressed: () => changeHour(1),
                    ),
                    Text(
                      h.toString().padLeft(2, '0'),
                      style: const TextStyle(
                        fontSize: 28,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.expand_more),
                      onPressed: () => changeHour(-1),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    ':',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Minute picker
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.expand_less),
                      onPressed: () => changeMinute(1),
                    ),
                    Text(
                      m.toString().padLeft(2, '0'),
                      style: const TextStyle(
                        fontSize: 28,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.expand_more),
                      onPressed: () => changeMinute(-1),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '(each second = 1 minute)',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        );
      },
    );
  }
}
