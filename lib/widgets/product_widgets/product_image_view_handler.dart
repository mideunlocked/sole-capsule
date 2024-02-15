import 'package:flutter/material.dart';

class ProdImageViewHandler extends StatelessWidget {
  const ProdImageViewHandler({
    super.key,
    required this.icon,
    this.onTap,
    required this.visible,
  });

  final bool visible;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
