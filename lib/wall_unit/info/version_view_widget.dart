import 'package:flutter/material.dart';
import 'base_field_info_view.dart';

class VersionViewWidget extends StatelessWidget {
  final VoidCallback onClose;

  const VersionViewWidget({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return BaseFieldInfoView(
      title: 'Version Info',
      onBack: onClose,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Wall Unit Version: 4.1'),
          SizedBox(height: 8),
          Text('Roof Unit Version: 4.4'),
        ],
      ),
    );
  }
}