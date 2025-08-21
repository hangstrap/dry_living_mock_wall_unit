import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'base_field_info_view.dart';

class ContactViewWidget extends StatelessWidget {
  final VoidCallback onClose;

  const ContactViewWidget({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return BaseFieldInfoView(
      title: 'Contact',
      onBack: onClose,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Scan to send an email',
          ),
          const SizedBox(height: 16),
          Center(
            child: QrImageView(
              data: 'https://www.dryliving.co.nz/contact-us',
              version: QrVersions.auto,
              size: 160,
            ),
          ),
        ],
      ),
    );
  }
}