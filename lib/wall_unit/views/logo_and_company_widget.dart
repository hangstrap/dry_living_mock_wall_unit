import 'package:flutter/material.dart';

class LogoAndCompany extends StatelessWidget {
  const LogoAndCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            //height: 40,
            child: Image.asset(
              'assets/dry_living_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Dehumidifier Ventilation System',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}