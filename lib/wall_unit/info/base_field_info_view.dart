import 'package:flutter/material.dart';

class BaseFieldInfoView extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onBack;

  const BaseFieldInfoView({
    super.key,
    required this.title,
    required this.child,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 328,
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Expanded(child: child),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack,
            ),
          ),
        ],
      ),
    );
  }
}