import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'SOLE',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: size,
          ),
        ),
        Text(
          'CAPSULE',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: size,
          ),
        ),
      ],
    );
  }
}
