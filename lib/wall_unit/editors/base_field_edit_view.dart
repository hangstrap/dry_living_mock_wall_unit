import 'package:flutter/material.dart';

class BaseFieldEditView<T> extends StatefulWidget {
  final String title;
  final T value;
  final ValueChanged<T> onSave;
  final Widget Function(T?, ValueChanged<T?>) editorBuilder;

  const BaseFieldEditView({
    required this.title,
    required this.value,
    required this.onSave,
    required this.editorBuilder,
    super.key,
  });

  @override
  State<BaseFieldEditView<T>> createState() => _BaseFieldEditViewState<T>();
}

class _BaseFieldEditViewState<T> extends State<BaseFieldEditView<T>> {
  late T currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final maxEditorHeight = MediaQuery.of(context).size.height * 0.7;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: maxEditorHeight,
                  ),
                  child: widget.editorBuilder(
                    currentValue,
                    (newValue) {
                      if (newValue != null) setState(() => currentValue = newValue);
                    },
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onSave(currentValue);
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}