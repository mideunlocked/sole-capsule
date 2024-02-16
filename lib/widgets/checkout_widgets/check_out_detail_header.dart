import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckoutDetailsHeader extends StatelessWidget {
  const CheckoutDetailsHeader({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: 3.h),
      ],
    );
  }
}
