import 'package:flutter/material.dart';

class EnumRadioSelector<T> extends StatefulWidget {
  final List<T> options;
  final T initialValue;
  final String Function(T) displayStringForOption;
  final void Function(T selected) onResult;

  const EnumRadioSelector({
    super.key,
    required this.options,
    required this.initialValue,
    required this.displayStringForOption,
    required this.onResult,
  });

  @override
  State<EnumRadioSelector<T>> createState() => _EnumRadioSelectorState<T>();
}

class _EnumRadioSelectorState<T> extends State<EnumRadioSelector<T>> {
  late T selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Compact radio options
        ...widget.options.map((option) {
          final label = widget.displayStringForOption(option);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio<T>(
                  value: option,
                  groupValue: selected,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selected = val);
                      widget.onResult(val);
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => selected = option);
                    widget.onResult(option);
                  },
                  child: Text(label),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
