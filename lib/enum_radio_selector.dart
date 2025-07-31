import 'package:flutter/material.dart';

class EnumRadioSelector<T> extends StatefulWidget {
  final String title;
  final List<T> options;
  final T initialValue;
  final String Function(T) displayStringForOption;
  final void Function(T selected) onResult;

  const EnumRadioSelector({
    super.key,
    required this.title,
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
        // Title row with centered, bold text
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Center(
            child: Text(
              widget.title,
              //style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),



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
                    }
                  },
                ),
                GestureDetector(
                  onTap: () => setState(() => selected = option),
                  child: Text(label),
                ),
              ],
            ),
          );
        }),

        // Buttons row
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 2),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       ElevatedButton(
        //         onPressed: () {
        //           widget.onResult(selected);
        //         },
        //         child: const Text('OK-'),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           widget.onResult(widget.initialValue);
        //         },
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.grey,
        //         ),
        //         child: const Text('Cancel'),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
